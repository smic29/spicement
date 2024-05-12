class User < ApplicationRecord
  belongs_to :company
  has_many :clients
  has_many :forwarders
  has_many :quotations
  has_many :bookings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
