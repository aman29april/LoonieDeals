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
class DailyPrice < ApplicationRecord
  belongs_to :quote

  validates :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  monetize :close_cents,
           :open_cents, :high_cents,
           :low_cents, :price_cents,
           allow_nil: true, with_model_currency: :currency
end
