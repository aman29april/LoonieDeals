# frozen_string_literal: true

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
