# frozen_string_literal: true

FactoryBot.define do
  factory :shareholding_pattern do
    shareholding_period { nil }
    shareholder_name { 'MyString' }
    shareholding_percentage { 1.5 }
  end
end
