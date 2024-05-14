class Forwarder < ApplicationRecord
  belongs_to :user
  has_many :people
  has_many :bookings

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :name, length: { maximum: 100 }
end
