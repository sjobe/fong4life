class Emergency
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Versioning
  has_one :donation, as: :eventable
  has_and_belongs_to_many :pending_matches, class_name: "Donor", inverse_of: nil
  has_and_belongs_to_many :contacted_matches, class_name: "Donor", inverse_of: nil

  
  field :title, type: String
  field :description, type: String
  field :sms_message_text, type: String
  field :created_by, type: String
  field :match_found, type: Boolean, default: false
  field :match_details, type: String
  field :blood_group, type: String
  field :status, type: String
  field :contact_phone_number, type: String
  field :hospital_name, type: String
  
  validates_presence_of :title, :description, :blood_group
  
  attr_accessor :contact_next_batch, :donor_id, :create_draft_facebook_post
  
  #TODO: Add a EmergencyComments; so emergency has_many comments
  
  after_create :set_status_to_draft, :populate_matches
  after_update :trigger_contact_matches, :close_emergency
  
  BATCH_SIZE = 5
  
  STATUS_DRAFT = 'draft'
  STATUS_ACTIVE = 'active'
  STATUS_CLOSE = 'closed'
  
  SMS_TEMPLATE = "Urgent!! Blood donation needed. You are a match, please contact ::CONTACT_PHONE_NUMBER:: or go to ::HOSPITAL_NAME:: as soon as possible"

  def generated_sms_message
    SMS_TEMPLATE.gsub('::CONTACT_PHONE_NUMBER::', self.contact_phone_number).gsub('::HOSPITAL_NAME::', self.hospital_name)
  end

  def trigger_contact_matches
    self.contact_matches if (status_was == STATUS_DRAFT && status == STATUS_ACTIVE) || self.contact_next_batch
  end
  
  def close_emergency
    if (status_was == STATUS_ACTIVE && status == STATUS_CLOSE) && self.donor_id.present?
      donation = Donation.new
      donation.donor = Donor.find(self.donor_id)
      donation.eventable = self
      donation.save
    end
  end
  
  def set_status_to_draft
    self.status = STATUS_DRAFT
    self.save

    if self.create_draft_facebook_post.present?
      FacebookPost.create(message: self.generated_sms_message, draft: true)
    end
  end
  
  def num_matches
    self.pending_matches.count + self.contacted_matches.count
  end
  
  def populate_matches
    # picks out a bunch of matches given criteria, and populates the pending matches list
    if self.blood_group == Donor::BLOOD_TYPE_UNIVERSAL_RECIPIENT 
      donors = Donor.all
    else
      donors = Donor.in(blood_group: [self.blood_group, Donor::BLOOD_TYPE_UNIVERSAL_DONOR])
    end
    # TODO: Fancy sorting happens here
    donors.each {|donor| self.pending_matches << donor}
    self.save 
  end
  
  def contact_matches(batch_size = BATCH_SIZE)
    # contact some or possibly all of the people we just selected out, depending on
    # batch size and move them to the contacted matches list
    count = 0
    while ((self.pending_matches.count > 0) && (count < batch_size)) do
      puts "COUNT - #{count}"
      current_donor = self.pending_matches.first
      self.pending_matches.delete Donor.find(self.pending_matches.first.id) # delete association
      current_donor.send_sms_message(generated_sms_message)  
      current_donor.update_attribute(:last_emergency_contact_date, Time.now)
      self.contacted_matches << current_donor
      count += 1
    end    
    #WARNING: DO NOT EVER CALL .save in HERE. Throws us into an infinite loop and potentially spams via SMS
  end
  
end
