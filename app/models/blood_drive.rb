class BloodDrive
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :donations, as: :eventable

  field :location, type: String
  field :date, type: DateTime
  field :description, type: String
end