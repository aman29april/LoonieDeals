# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MutualFund, type: :model do
  context 'validations' do
    it 'is valid with a symbol and fund name' do
      mutual_fund = MutualFund.new(symbol: 'FMAGX', fund_name: 'Fidelity Magellan Fund')
      expect(mutual_fund).to be_valid
    end

    it 'is invalid without a symbol' do
      mutual_fund = MutualFund.new(fund_name: 'Fidelity Magellan Fund')
      expect(mutual_fund).to_not be_valid
    end

    it 'is invalid without a fund name' do
      mutual_fund = MutualFund.new(symbol: 'FMAGX')
      expect(mutual_fund).to_not be_valid
    end
  end

  context 'associations' do
    it 'inherits from quote' do
      expect(MutualFund.superclass).to eq(Quote)
    end
  end
end
