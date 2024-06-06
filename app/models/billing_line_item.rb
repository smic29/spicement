class BillingLineItem < ApplicationRecord
  belongs_to :billing

  ISO_CURRENCIES = %w[PHP USD].freeze

  validates :currency, length: { is: 3 }, inclusion: { in: ISO_CURRENCIES }
  validates :description, length: { maximum: 255 }
  validates :cost, :total, :quantity, numericality: { greater_than_or_equal_to: 0 }
end
