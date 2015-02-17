namespace :f4l do
  task :remind_donors => :environment  do
    Donor.includes(:donations).or(
      { last_reminder_date: nil },
      { last_reminder_date: { '$lt' => 2.weeks.ago } }, 
      ).select(&:can_donate_now?).each do |donor| 
        donor.send_reminder
      end
  end
end