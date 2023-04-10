# frozen_string_literal: true

FactoryBot.define do
  factory :ratio do
    name { 'MyString' }
    value { '9.99' }
    year { 1 }
    company { nil }
  end
end
