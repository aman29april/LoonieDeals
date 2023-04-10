# frozen_string_literal: true

FactoryBot.define do
  factory :quote_price do
    association :quote
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    open_price { Faker::Number.decimal(l_digits: 2) }
    close_price { Faker::Number.decimal(l_digits: 2) }
    high_price { Faker::Number.decimal(l_digits: 2) }
    low_price { Faker::Number.decimal(l_digits: 2) }
    volume { Faker::Number.number(digits: 6) }
  end
end
