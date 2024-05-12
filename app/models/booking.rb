class Booking < ApplicationRecord
  belongs_to :quotation
  belongs_to :user
  belongs_to :forwarder
  has_many :quote_line_items, through: :quotation

  delegate :client, to: :quotation
end
