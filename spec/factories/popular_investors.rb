# frozen_string_literal: true

# == Schema Information
#
# Table name: popular_investors
#
#  id         :integer          not null, primary key
#  age        :integer
#  bio        :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :popular_investor do
    name { 'MyString' }
    age { 1 }
    bio { 'MyText' }
    portfolio { 'MyText' }
  end
end
