# frozen_string_literal: true

# == Schema Information
#
# Table name: portfolios
#
#  id                   :integer          not null, primary key
#  number_of_shares     :integer
#  quarter              :integer
#  year                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  popular_investors_id :integer          not null
#
# Indexes
#
#  index_portfolios_on_popular_investors_id  (popular_investors_id)
#
# Foreign Keys
#
#  popular_investors_id  (popular_investors_id => popular_investors.id)
#
FactoryBot.define do
  factory :portfolio do
    popular_investor { nil }
  end
end
