# frozen_string_literal: true

# == Schema Information
#
# Table name: social_accounts
#
#  id               :integer          not null, primary key
#  url              :string
#  number_of_clicks :integer          default(0)
#  position         :integer
#  account_type     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :social_account do
    url { 'MyString' }
    number_of_clicks { 1 }
    position { 1 }
    account_type { 'MyString' }
  end
end
