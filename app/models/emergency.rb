class Emergency
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Versioning
  has_one :donation, as: :eventable

  field :details, type: String
  field :sms_message_text, type: String
  field :created_by, type: String
  field :donor_found, type: Boolean, default: false
  field :donor_details, type: String
end