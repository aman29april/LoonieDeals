# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    event_type { Event::TYPES.sample }
    date { Faker::Date.between(from: 2.years.ago, to: Date.today) }
    description { Faker::Lorem.paragraph }
    company { create(:company) }
  end
end
