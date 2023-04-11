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
class QuotePrice < ApplicationRecord
  belongs_to :quote

  validates :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
