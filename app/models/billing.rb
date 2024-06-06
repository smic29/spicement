class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :booking
  belongs_to :quotation
  has_many :billing_line_items

  accepts_nested_attributes_for :quotation, :booking, update_only: true
  accepts_nested_attributes_for :billing_line_items, allow_destroy: true

  DOC_TYPES = ['Billing Invoice', 'Statement of Account'].freeze

  validates :user, :booking, :quotation, presence: true
  validates :total_amount, :ex_rate, numericality: true, allow_nil: true
  validates :status, inclusion: { in: %w(Draft Sent Paid) }
end
