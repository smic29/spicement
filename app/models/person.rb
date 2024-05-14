class Person < ApplicationRecord
  include Nameable

  belongs_to :client, optional: true
  belongs_to :forwarder, optional: true
end
