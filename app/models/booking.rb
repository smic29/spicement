class Booking < ApplicationRecord
  belongs_to :quotation
  belongs_to :user
  has_one :forwarder
  has_many :quote_line_items, through: :quotation
  has_many :billings

  delegate :client, to: :quotation

  before_create :generate_unique_reference

  validates :quotation_id, :user_id, presence: true
  validates :cost, :receivable, :profit, numericality: true
  validates :status, inclusion: { in: %w(Ongoing Completed Cancelled) }
  validates :b_reference, uniqueness: { scope: :user_id }

  private

  def generate_unique_reference
    self.b_reference ||= loop do
      random_token = "B-#{SecureRandom.hex(4)}"
      break random_token unless self.class.exists?(b_reference: random_token)
    end
  end

end
