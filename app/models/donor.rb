class Donor
  include Mongoid::Document
  #include Mongoid::Versioning
  include Mongoid::Timestamps
  has_many :donations

  validates_presence_of :first_name, :last_name, :date_of_birth, :sex, :address, :primary_phone_number, :blood_group, :donor_card_id
  validates_uniqueness_of :primary_phone_number
  validates :primary_phone_number, :secondary_phone_number, length: {in: 7..13}

  DEFAULT_COUNTRY_CODE = '220'

  BLOOD_TYPE_A_POS = 'A POS'
  BLOOD_TYPE_A_NEG = 'A NEG'
  BLOOD_TYPE_UNIVERSAL_DONOR = 'O NEG'
  BLOOD_TYPE_AB_POS = 'AB POS'
  BLOOD_TYPE_UNIVERSAL_RECIPIENT = 'AB NEG'
  BLOOD_TYPE_B_POS = 'B POS'
  BLOOD_TYPE_B_NEG = 'B NEG'
  BLOOD_TYPE_O_POS = 'O POS'
  
  BLOOD_GROUPS = [BLOOD_TYPE_A_POS, BLOOD_TYPE_A_NEG, BLOOD_TYPE_B_POS, 
                 BLOOD_TYPE_B_NEG, BLOOD_TYPE_O_POS, BLOOD_TYPE_UNIVERSAL_DONOR, 
                  BLOOD_TYPE_AB_POS, BLOOD_TYPE_UNIVERSAL_RECIPIENT]
  field :first_name, type: String
  field :last_name, type: String
  field :date_of_birth, type: Date
  field :sex, type: String
  field :address, type: String
  field :primary_phone_number, type: String
  field :secondary_phone_number, type: String
  field :blood_group, type: String
  field :email_address, type: String
  field :donor_card_id, type: String



  def can_donate_now?

  end
  
  def autocomplete_text
    "#{first_name} #{last_name} | #{primary_phone_number}"
  end
  
  def send_sms_message(message_body)
    number = primary_phone_number
    number = "+#{COUNTRY_CODE}#{number}" unless number.start_with?('+')
    
    PhoneNumber.send_sms_message_to_number(message_body, number)
  end

end