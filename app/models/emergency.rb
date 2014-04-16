class Emergency
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Versioning
  has_one :donation, as: :eventable

  field :details, type: String
  field :sms_message_text, type: String
  field :created_by, type: String
  field :donor_found, type: Boolean, default: false
  field :donor_details, type: String
  field :blood_type, type: String
  field :pending_matches, type: Array
  field :contacted_matches, type: Array

  after_create :find_and_contact_matches
  
  def find_and_contact_matches
    # call populate matches
    # call contact_matches
  end
  
  def populate_matches
    # store the matches in pending matches    
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