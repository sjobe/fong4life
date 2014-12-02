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

  validates_presence_of :title, :description, :blood_group
  
  #TODO: Add a EmergencyComments; so emergency has_many comments
  
  after_create :set_status_to_draft, :populate_matches
  after_update :activate
  
  BATCH_SIZE = 5
  
  STATUS_DRAFT = 'draft'
  STATUS_ACTIVE = 'active'
  STATUS_CLOSE = 'closed'
  
  def activate
    if status_was == STATUS_DRAFT && status == STATUS_ACTIVE
      self.contact_matches
    end
  end
  
  def set_status_to_draft
    self.status = STATUS_DRAFT
    self.save
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
     # current_donor.send_sms_message(self.sms_message_text)  
      puts "here #{self.pending_matches.count}"
      puts current_donor.first_name
      self.contacted_matches << current_donor
      count += 1
    end    
    #WARNING: DO NOT EVER CALL .save in HERE. Throws us into an infinite loop and potentially spams via SMS
  end
  
  def close_emergency(donor_found, donor_details)
    # set donor found
    # set donor_details if any
  end
  
end