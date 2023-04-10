# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    ticker { Faker::Finance.ticker }
    exchange { Exchange.find_or_create_by(name: 'NYSE') }
    sector { Sector.find_or_create_by(name: 'Technology') }
    website { Faker::Internet.url }
    description { Faker::Company.catch_phrase }
    founded_year { Faker::Date.between(from: 50.years.ago, to: 10.years.ago).year }
    employees { Faker::Number.between(from: 100, to: 100_000) }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    country { Faker::Address.country }

    trait :with_financials do
      after(:create) do |company|
        create_list(:balance_sheet, 4, company:)
        create_list(:profit_and_loss, 4, company:)
        create_list(:cash_flow, 4, company:)
        create_list(:ratio, 4, company:)
      end
    end
  end
end
