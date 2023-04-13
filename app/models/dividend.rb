# frozen_string_literal: true

# == Schema Information
#
# Table name: dividends
#
#  id               :integer          not null, primary key
#  amount_cents     :integer
#  currency         :string           default("USD"), not null
#  date             :date
#  declaration_date :date
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
  validates :amount_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  monetize :amount_cents, with_model_currency: :currency
end
