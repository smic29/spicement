class User < ApplicationRecord
  include Nameable

  belongs_to :company
  has_many :people
  has_many :clients
  has_many :forwarders
  has_many :quotations
  has_many :bookings
  has_many :billings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { case_sensitive: false, scope: :company_id }

  def will_save_change_to_email?
    false
  end

  def email_changed?
    false
  end

  def manager?
    self.email == self.company.email
  end
end
