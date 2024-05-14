class Person < ApplicationRecord
  include Nameable

  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :forwarder, optional: true

  validates :email, presence: true, uniqueness: { scope: :user_id }
end
