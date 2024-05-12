class Person < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :forwarder, optional: true
end
