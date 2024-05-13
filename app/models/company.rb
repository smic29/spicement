class Company < ApplicationRecord
  before_create :generate_company_code
  has_many :users, dependent: :destroy
  has_many :clients, through: :users
  has_many :forwarders, through: :users
  has_many :quotations, through: :users
  has_many :bookings, through: :users
  has_many :billings, through: :users

  validate :approved_not_present_on_creation
  validates :name, presence: true
  validates :email, presence: true

  private

  def generate_company_code
    words = name.split(/\s+/)
    initials = words.map { |word| word.slice(0, 2).upcase }.join

    if initials.length < 4
      self.company_code = initials + SecureRandom.hex(2).upcase[0..3]
    else
      base_code = initials[0..3]
      random_code = SecureRandom.hex(1).upcase

      self.company_code = "#{base_code}#{random_code}"
    end
  end

  def approved_not_present_on_creation
    errors.add(:approved, "should not be present on creations") if approved.present? & !persisted?
  end

end
