# frozen_string_literal: true

FactoryBot.define do
  factory :popular_investor do
    name { 'MyString' }
    age { 1 }
    bio { 'MyText' }
    portfolio { 'MyText' }
  end
end
