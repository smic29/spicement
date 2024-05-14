FactoryBot.define do
  factory :forwarder do
    name { Faker::Company.name }
    user
  end
end
