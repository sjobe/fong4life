class Donor
  include Mongoid::Document
  #include Mongoid::Versioning
  include Mongoid::Timestamps
  has_many :donations

  validates_presence_of :first_name, :last_name, :date_of_birth, :sex, :address, :primary_phone_number, :blood_group
  validates_uniqueness_of :primary_phone_number
  validates :primary_phone_number, length: {in: 7..13}

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
  SEX_MALE = 'M'
  SEX_FEMALE = 'F'
  SEX = [SEX_MALE, SEX_FEMALE]

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
  field :last_emergency_contact_date, type: DateTime 
  field :last_reminder_message_date, type: DateTime 
  field :created_by_user_id, type: BSON::ObjectId
  
  def can_donate_now?
    !last_donation.present? || (last_donation.present? && can_donate?(last_donation.created_at))
  end
    
  def can_donate?(last_donation_date)
   (SEX_MALE == sex && last_donation_date < 3.months.ago) || (SEX_FEMALE == sex && last_donation_date < 6.months.ago)
  end
  
  def last_donation
    self.donations.order_by(created_at: 'asc').last
  end
  
  def autocomplete_text
    "#{first_name} #{last_name} | #{primary_phone_number}"
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def send_reminder
    reminder_message = "Hello #{self.full_name}.\n You haven't donated since ..., please go to RVH or similar"
    upcoming = BloodDrive.where(:date.gt => DateTime.now.at_beginning_of_day)
    if upcoming.count > 0 
      reminder_message = "Hello #{self.full_name}.\n There will be a F4L blood drive .... please show up. see below for details"
      upcoming.all.each do |blood_drive|  
        reminder_message += "#{blood_drive.location} - #{blood_drive.date.strftime('%A, %d %b %Y, %l:%M %p')}\n"
      end
    end
  puts reminder_message
    #self.send_sms_message(reminder_message)
    #    current_donor.update_attribute(:last_reminder_date, Time.now)
  end
  
  def send_sms_message(message_body)    
    if Rails.env == 'production'
      number = primary_phone_number
      number = "+#{COUNTRY_CODE}#{number}" unless number.start_with?('+')
    else      
      number = ENV['F4L_TESTING_NUMBERS'].split(',').sample 
      message_body = "F4L Message from #{Rails.env} = #{message_body}"
    end
    PhoneNumber.send_sms_message_to_number(message_body, number)
  end

end