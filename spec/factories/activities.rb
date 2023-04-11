# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  action       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  portfolio_id :integer          not null
#  quote_id     :integer          not null
#
# Indexes
#
#  index_activities_on_portfolio_id  (portfolio_id)
#  index_activities_on_quote_id      (quote_id)
#
# Foreign Keys
#
#  portfolio_id  (portfolio_id => portfolios.id)
#  quote_id      (quote_id => quotes.id)
#
FactoryBot.define do
  factory :activity do
    portfolio { nil }
    action { 1 }
    quote { nil }
  end
end
