json.array!(@donors) do |donor|
  json.extract! donor, :first_name, :last_name, :date_of_birth, :sex, :address, :primary_phone_number, :secondary_phone_number, :blood_group, :email_address, :donor_card_id
  json.url donor_url(donor, format: :json)
end
