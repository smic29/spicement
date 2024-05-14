FactoryBot.define do
  factory :booking do
    services { Faker::Commerce.department }
    bl_number { Faker::Alphanumeric.alphanumeric(number: 10).upcase }
    cost { Faker::Commerce.price(range: 100.00..1000.00) }
    receivable { Faker::Commerce.price(range: 100.00..2000.00) }
    profit { Faker::Commerce.price(range: 100.00..500.00) }
    status { %w(Ongoing Completed Cancelled).sample }
    eta { Faker::Date.forward(days: 30) }
    user
    forwarder
    quotation
  end
end
