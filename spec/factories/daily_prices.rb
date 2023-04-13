# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_prices
#
#  id              :integer          not null, primary key
#  adj_close_cents :integer
#  close_cents     :integer
#  currency        :string           default("USD"), not null
#  date            :date
#  high_cents      :integer
#  low_cents       :integer
#  open_cents      :integer
#  price_cents     :integer
#  volume          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  quote_id        :integer          not null
#
# Indexes
#
#  index_daily_prices_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :daily_price do
    association :quote
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    open_price { Faker::Number.decimal(l_digits: 2) }
    close_price { Faker::Number.decimal(l_digits: 2) }
    high_price { Faker::Number.decimal(l_digits: 2) }
    low_price { Faker::Number.decimal(l_digits: 2) }
    volume { Faker::Number.number(digits: 6) }
  end
end
