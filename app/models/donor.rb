class Donor
  include Mongoid::Document
  #include Mongoid::Versioning
  include Mongoid::Timestamps
  has_many :donations

  BLOOD_TYPES = ['A POS', 'A NEG', 'B POS', 
                  'B NEG', 'O POS', 'O NEG', 
                  'AB POS', 'AB NEG']
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
  validates_uniqueness_of :primary_phone_number


  def can_donate_now?

  end
  
  def autocomplete_text
    "#{first_name} #{last_name} | #{primary_phone_number}"
  end
  
  

end