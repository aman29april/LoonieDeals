# frozen_string_literal: true

FactoryBot.define do
  factory :exchange do
    name { Faker::Company.name }
    country { Faker::Address.country }
  end
end
