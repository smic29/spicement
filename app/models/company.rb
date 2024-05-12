class Company < ApplicationRecord
  before_create :generate_company_code
  has_many :users
  has_many :clients, through: :users

  validates :name, presence: true

  private

  def generate_company_code
    base_code = name.parameterize(separator: '_').upcase
    random_code = SecureRandom.hex(2).upcase
    self.company_code = "#{base_code[0..4]}#{random_code}"
  end

end
