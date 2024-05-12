class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :booking
  belongs_to :quotation
end
