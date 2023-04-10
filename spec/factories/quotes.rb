# frozen_string_literal: true

FactoryBot.define do
  factory :quote do
    name { 'MyString' }
    ticker { 'MyString' }
    exchange { nil }
    sector { 'MyString' }
    industry { 'MyString' }
    market_cap { 1 }
    employees { 1 }
    description { 'MyText' }
    website { 'MyString' }
    phone { 'MyString' }
    address { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    zip { 'MyString' }
    country { 'MyString' }
  end
end
