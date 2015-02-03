namespace :f4l do
  task :remind_donors => :environment  do
    Donor.includes(:donations).or(
      { last_reminder_date: nil },
      { sex: Donor::SEX_MALE, last_reminder_date: { '$gt' => 3.months.ago } }, 
      { sex: Donor::SEX_FEMALE, last_reminder_date: { '$gt' => 6.months.ago } }
      ).select(&:can_donate_now?).each do |donor| 
        puts donor.full_name
      end
  end
end