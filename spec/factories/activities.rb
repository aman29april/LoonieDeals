# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    portfolio { nil }
    action { 1 }
    quote { nil }
  end
end
