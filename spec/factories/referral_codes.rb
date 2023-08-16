# frozen_string_literal: true

FactoryBot.define do
  factory :referral_code do
    referal_link { 'MyString' }
    referal_code { 'MyString' }
    referal_text { 'MyText' }
    position { 1 }
    enabled { false }
    deal { nil }
  end
end
