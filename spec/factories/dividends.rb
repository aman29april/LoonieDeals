# frozen_string_literal: true

FactoryBot.define do
  factory :dividend do
    company { nil }
    ex_dividend_date { '2023-04-10' }
    payment_date { '2023-04-10' }
    amount { 1.5 }
  end
end
