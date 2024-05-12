class Forwarder < ApplicationRecord
  belongs_to :user
  has_many :people
  has_many :bookings
end
