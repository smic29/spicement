FactoryBot.define do
  factory :person do
    user
    client
    forwarder
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
