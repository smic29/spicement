class Client < ApplicationRecord
  belongs_to :user
  has_many :people
  has_many :bookings, through: :user
  has_many :quotations
  has_many :billings, through: :quotations

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :name, length: { maximum: 100 }
end
