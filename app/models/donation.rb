class Donation
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :donor
  belongs_to :eventable, polymorphic: true

  field :comments, type: String
end