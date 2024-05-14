FactoryBot.define do
  factory :billing do
    total_amount { Faker::Commerce.price(range: 100.00..1000.00) }
    ex_rate { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { %w(Draft Sent Paid).sample }
    user
    booking
    quotation
  end
end
