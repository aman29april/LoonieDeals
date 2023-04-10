# frozen_string_literal: true

FactoryBot.define do
  factory :shareholding_period do
    company { nil }
    period_type { 'MyString' }
    start_date { '2023-04-10' }
    end_date { '2023-04-10' }
  end
end
