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

  after_create :find_and_contact_matches
  
  BATCH_SIZE = 5
  
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
  
  def contact_matches(batch_size = BATCH_SIZE)
    count = 0
    while self.pending_matches.count > 0 && count%batch_size != 0
      current_donor = self.pending_matches.pop
      #      current_donor.contact(self) #TODO: SMS Sending here; need to implement
      self.contacted_matches << current_donor
      self.save
      count++;
    end    
  end
  
  def close_emergency(donor_found, donor_details)
    # set donor found
    # set donor_details if any
  end
  
end