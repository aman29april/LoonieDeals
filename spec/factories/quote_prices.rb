# frozen_string_literal: true

# == Schema Information
#
# Table name: quote_prices
#
#  id              :integer          not null, primary key
#  adj_close_price :float
#  close_price     :decimal(, )
#  date            :date
#  high_price      :decimal(, )
#  low_price       :decimal(, )
#  open_price      :decimal(, )
#  price           :float
#  volume          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  quote_id        :integer          not null
#
# Indexes
#
#  index_quote_prices_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :quote_price do
    association :quote
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    open_price { Faker::Number.decimal(l_digits: 2) }
    close_price { Faker::Number.decimal(l_digits: 2) }
    high_price { Faker::Number.decimal(l_digits: 2) }
    low_price { Faker::Number.decimal(l_digits: 2) }
    volume { Faker::Number.number(digits: 6) }
  end
end
