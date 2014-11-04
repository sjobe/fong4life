# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do 
  Donor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, date_of_birth: Faker::Date.between(40.years.ago, 21.years.ago), sex: %w{M F}.sample, address: Faker::Address.city,
    primary_phone_number: Faker::Number.number(10), secondary_phone_number: Faker::Number.number(10), blood_group: Donor::BLOOD_GROUPS.sample, email_address: Faker::Internet.email)
end
