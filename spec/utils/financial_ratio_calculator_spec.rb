# frozen_string_literal: true

RSpec.describe FinancialRatioCalculator do
  describe '.gross_profit_margin' do
    it 'calculates the gross profit margin for a given company' do
      company = FactoryBot.create(:company)
      revenue = 100_000
      cost_of_goods_sold = 60_000
      gross_profit = revenue - cost_of_goods_sold

      expect(FinancialRatioCalculator.gross_profit_margin(company, revenue, gross_profit)).to eq(0.4)
    end
  end

  describe '.net_profit_margin' do
    it 'calculates the net profit margin for a given company' do
      company = FactoryBot.create(:company)
      revenue = 100_000
      expenses = 80_000
      net_income = revenue - expenses

      expect(FinancialRatioCalculator.net_profit_margin(company, revenue, net_income)).to eq(0.2)
    end
  end

  describe '.return_on_investment' do
    it 'calculates the return on investment for a given company' do
      company = FactoryBot.create(:company)
      net_income = 50_000
      total_assets = 100_000

      expect(FinancialRatioCalculator.return_on_investment(company, net_income, total_assets)).to eq(0.5)
    end
  end

  describe '.return_on_capital_employed' do
    it 'calculates the return on capital employed for a given company' do
      company = FactoryBot.create(:company)
      nopat = 40_000
      total_capital_employed = 80_000

      expect(FinancialRatioCalculator.return_on_capital_employed(company, nopat, total_capital_employed)).to eq(0.5)
    end
  end

  describe '.pe_ratio' do
    it 'calculates the price-to-earnings ratio for a given company' do
      company = FactoryBot.create(:company)
      earnings_per_share = 5
      market_price_per_share = 50

      expect(FinancialRatioCalculator.pe_ratio(company, earnings_per_share,
                                               market_price_per_share)).to eq(10)
    end
  end
end
