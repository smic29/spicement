FactoryBot.define do
  factory :quotation do
    incoterm { %w(EXW FOB CIF).sample }
    exchange_rate { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    origin { Faker::Address.city }
    destination { Faker::Address.city }
    total_price { Faker::Commerce.price(range: 500.00..5000.00) }
    status { %w(draft sent accepted rejected).sample }
    user
    client
  end
end
