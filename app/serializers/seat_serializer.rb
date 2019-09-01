class SeatSerializer < ActiveModel::Serializer
  attributes :idx

  has_many :positions
end
