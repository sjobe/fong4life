json.array!(@emergencies) do |emergency|
  json.extract! emergency, :id, :details, :sms_message_text
  json.url emergency_url(emergency, format: :json)
end
