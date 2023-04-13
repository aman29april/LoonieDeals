# frozen_string_literal: true

# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  country    :string
#  currency   :string
#  full_name  :string
#  name       :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :exchange do
    name { Faker::Company.name }
    country { Faker::Address.country }
  end
end
