FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
  end
end
