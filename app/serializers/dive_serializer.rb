class DiveSerializer < ActiveModel::Serializer
  attributes :id, :location, :date, :length
  has_one :user
end
