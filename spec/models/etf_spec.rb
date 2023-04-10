# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ETF, type: :model do
  context 'validations' do
    it 'is valid with a symbol and fund name' do
      etf = ETF.new(symbol: 'SPY', fund_name: 'SPDR S&P 500 ETF')
      expect(etf).to be_valid
    end

    it 'is invalid without a symbol' do
      etf = ETF.new(fund_name: 'SPDR S&P 500 ETF')
      expect(etf).to_not be_valid
    end

    it 'is invalid without a fund name' do
      etf = ETF.new(symbol: 'SPY')
      expect(etf).to_not be_valid
    end
  end

  context 'associations' do
    it 'inherits from quote' do
      expect(ETF.superclass).to eq(Quote)
    end
  end
end
