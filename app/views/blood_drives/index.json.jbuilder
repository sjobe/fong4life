json.array!(@blood_drives) do |blood_drive|
  json.extract! blood_drive, :location, :date, :description
  json.url blood_drive_url(blood_drive, format: :json)
end
