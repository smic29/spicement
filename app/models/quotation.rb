class Quotation < ApplicationRecord
  belongs_to :user
  has_one :client
  has_many :quote_line_items
  has_many :billings

  accepts_nested_attributes_for :quote_line_items

  validates :user_id, presence: true
  validates :client_id, presence: true
  validates :status, inclusion: { in: %w(draft approved rejected) }
  validates :total_price, numericality: true

end
