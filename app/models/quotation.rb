class Quotation < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :quote_line_items
  has_many :billings
  has_one :booking

  accepts_nested_attributes_for :quote_line_items, allow_destroy: true
  accepts_nested_attributes_for :client

  before_create :generate_unique_reference

  validates :user_id, presence: true
  validates :client_id, presence: true
  validates :status, inclusion: { in: %w(draft approved rejected) }
  validates :total_price, numericality: true
  validates :reference, uniqueness: { scope: :user_id }

  private

  def generate_unique_reference
    self.reference ||= loop do
      random_token = "Q-#{SecureRandom.hex(4)}"
      break random_token unless self.class.exists?(reference: random_token)
    end
  end

end
