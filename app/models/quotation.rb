class Quotation < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :quote_line_items
  has_many :billings
end
