class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :booking
  belongs_to :quotation

  validates :user, :booking, :quotation, presence: true
  validates :total_amount, :ex_rate, numericality: true, allow_nil: true
  validates :status, inclusion: { in: %w(Draft Sent Paid) }
end
