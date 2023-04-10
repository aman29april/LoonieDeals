# frozen_string_literal: true

FactoryBot.define do
  factory :mutual_fund do
    sequence(:name) { |n| "MutualFund #{n}" }
    fund_family { 'MyString' }
    association :exchange
    net_asset_value { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    expense_ratio { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    dividend_yield { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
