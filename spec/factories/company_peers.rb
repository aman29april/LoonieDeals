# frozen_string_literal: true

FactoryBot.define do
  factory :company_peer do
    association :company
    association :peer, factory: :company

    trait :with_exchange do
      association :exchange
    end

    trait :with_sector do
      association :sector
    end
  end
end
