FactoryBot.define do
  factory :quote_line_item do
    description { Faker::Lorem.sentence }
    currency { QuoteLineItem::ISO_CURRENCIES.sample }
    cost { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    frequency { Faker::Lorem.word }
    quantity { Faker::Number.between(from: 1.0, to: 100.0).round(2) }
    total { (cost * quantity).round(2) }
    quotation
  end
end
