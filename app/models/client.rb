class Client < ApplicationRecord
  belongs_to :user
  has_many :people
  has_many :bookings, through: :user
end
