class Client < ApplicationRecord
  belongs_to :user
  has_many :people
  has_many :bookings, through: :user
  has_many :billings, through: :quotation
end
