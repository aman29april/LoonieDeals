# frozen_string_literal: true

# == Schema Information
#
# Table name: yearly_prices
#
#  id         :integer          not null, primary key
#  avg_cents  :integer
#  currency   :string           default("USD"), not null
#  high_cents :integer
#  low_cents  :integer
#  pe         :float
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quote_id   :integer          not null
#
# Indexes
#
#  index_yearly_prices_on_quote_id           (quote_id)
#  index_yearly_prices_on_quote_id_and_year  (quote_id,year) UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :yearly_price do
    quote { nil }
    year { 1 }
  end
end
