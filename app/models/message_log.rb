class MessageLog
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_one :donor
  field :env, type: String
  field :type, type: String
  field :from, type: String
  field :to, type: String
  field :message, type: String
  field :status, type: String
  
  TYPE_SMS = 'sms'
  TYPE_EMAIL = 'email'
end