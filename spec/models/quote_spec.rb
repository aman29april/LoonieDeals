# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id                      :integer          not null, primary key
#  address                 :string
#  beta                    :decimal(, )
#  ceo                     :string
#  city                    :string
#  country                 :string
#  description             :text
#  dividend_yield          :decimal(, )      default(0.0)
#  earnings_per_share      :decimal(, )
#  employees               :integer
#  exchange_url            :string
#  expense_ratio           :decimal(, )      default(0.0)
#  founded                 :date
#  fund_family             :string
#  industry                :string
#  ipo_year                :integer
#  market_cap              :integer
#  name                    :string
#  net_assets              :float
#  phone                   :string
#  price_to_book_ratio     :decimal(, )
#  price_to_earnings_ratio :decimal(, )
#  sector                  :string
#  state                   :string
#  ticker                  :string
#  type                    :string
#  website                 :string
#  zip                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  exchange_id             :integer          not null
#  sector_id               :integer          not null
#
# Indexes
#
#  index_quotes_on_exchange_id  (exchange_id)
#  index_quotes_on_sector_id    (sector_id)
#
# Foreign Keys
#
#  exchange_id  (exchange_id => exchanges.id)
#  sector_id    (sector_id => sectors.id)
#
require 'rails_helper'

RSpec.describe Quote, type: :model do
  context 'validations' do
    it 'is valid with symbol and company name' do
      quote = Quote.new(symbol: 'AAPL', company_name: 'Apple Inc.')
      expect(quote).to be_valid
    end

    it 'is invalid without a symbol' do
      quote = Quote.new(company_name: 'Apple Inc.')
      expect(quote).to_not be_valid
    end

    it 'is invalid without a company name' do
      quote = Quote.new(symbol: 'AAPL')
      expect(quote).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a portfolio' do
      association = Quote.reflect_on_association(:portfolio)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many quote prices' do
      association = Quote.reflect_on_association(:quote_prices)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many bookmarks' do
      association = Quote.reflect_on_association(:bookmarks)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many portfolios through bookmarks' do
      association = Quote.reflect_on_association(:portfolios)
      expect(association.macro).to eq(:has_many)
      expect(association.through_reflection.name).to eq(:bookmarks)
    end
  end
end
