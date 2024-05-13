FactoryBot.define do
  factory :client do
    name { Faker::Company.name }
    user
  end
end
