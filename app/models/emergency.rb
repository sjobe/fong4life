class Emergency
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Versioning
  has_one :donation, as: :eventable
  embeds_many :pending_matches, class_name: "Donor", store_as: 'pending_matches'
  embeds_many :contacted_matches, class_name: "Donor", store_as: 'contacted_matches'

  field :details, type: String
  field :sms_message_text, type: String
  field :created_by, type: String
  field :donor_found, type: Boolean, default: false
  field :donor_details, type: String
  field :blood_group, type: String
#  field :pending_matches, type: Array
#  field :contacted_matches, type: Array

  after_create :find_and_contact_matches
  
  def find_and_contact_matches
    # call populate matches
    # call contact_matches
  end
  
  def populate_matches
    if self.blood_group == Donor::BLOOD_TYPE_UNIVERSAL_RECIPIENT 
      donors = Donor.all
    else
      donors = Donor.in(blood_group: [self.blood_group, Donor::BLOOD_TYPE_UNIVERSAL_DONOR])
    end
    # TODO: Fancy sorting happens here
    self.pending_matches = donors
  end
  
  def contact_matches
    # Send SMS to the next x top matches in pending_matches
    # It's going to move the contacted matches from pending_matches to contacted_matches
  end
  
  def close_emergency(donor_found, donor_details)
    # set donor found
    # set donor_details if any
  end
  
end