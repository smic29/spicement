class Booking < ApplicationRecord
  belongs_to :quotation
  belongs_to :user
  belongs_to :forwarder
  has_many :quote_line_items, through: :quotation
  has_many :billings

  delegate :client, to: :quotation

  validates :quotation_id, :user_id, presence: true
  validates :cost, :receivable, :profit, numericality: true
  validates :status, inclusion: { in: %w(Ongoing Completed Cancelled) }
end
