FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company
  end
end
