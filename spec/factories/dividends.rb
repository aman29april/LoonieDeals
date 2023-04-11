# frozen_string_literal: true

# == Schema Information
#
# Table name: dividends
#
#  id               :integer          not null, primary key
#  amount           :float
#  dividend_date    :date
#  ex_dividend_date :date
#  payment_date     :date
#  record_date      :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  quote_id         :integer          not null
#
# Indexes
#
#  index_dividends_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :dividend do
    company { nil }
    ex_dividend_date { '2023-04-10' }
    payment_date { '2023-04-10' }
    amount { 1.5 }
  end
end
