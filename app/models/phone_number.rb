class PhoneNumber
   
  include Mongoid::Document
  #include Mongoid::Versioning
  include Mongoid::Timestamps

  def self.send_sms_message_to_number(message_body, to_number)
    twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    from_number = "+1#{ENV['TWILIO_PHNONE_NUMBER']}"
    status = twilio_client.account.sms.messages.create(
      :from => from_number,
      :to => to_number, #TODO: Do not send to actual numbers unless in production
      :body => message_body
    )
      MessageLog.create(env: Rails.env, type: MessageLog::TYPE_SMS, 
      from: ENV['TWILIO_PHNONE_NUMBER'], to: to_number, message: message_body, status: status)
  end

end
