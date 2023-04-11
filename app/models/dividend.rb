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
class Dividend < ApplicationRecord
  belongs_to :quote

  validates :record_date, presence: true
  validates :payment_date, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
