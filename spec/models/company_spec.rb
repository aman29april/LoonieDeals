# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { FactoryBot.create(:company) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:ticker) }
    it { should validate_uniqueness_of(:ticker) }
    it { should validate_presence_of(:exchange_id) }
  end

  describe 'associations' do
    it { should belong_to(:exchange) }
    it { should have_many(:balance_sheets).dependent(:destroy) }
    it { should have_many(:profit_and_loss_statements).dependent(:destroy) }
    it { should have_many(:cash_flows).dependent(:destroy) }
  end

  context 'validations' do
    it 'is valid with a symbol, company name, and industry' do
      company = Company.new(symbol: 'AAPL', company_name: 'Apple Inc.', industry: 'Technology')
      expect(company).to be_valid
    end

    it 'is invalid without a symbol' do
      company = Company.new(company_name: 'Apple Inc.', industry: 'Technology')
      expect(company).to_not be_valid
    end

    it 'is invalid without a company name' do
      company = Company.new(symbol: 'AAPL', industry: 'Technology')
      expect(company).to_not be_valid
    end

    it 'is invalid without an industry' do
      company = Company.new(symbol: 'AAPL', company_name: 'Apple Inc.')
      expect(company).to_not be_valid
    end
  end

  context 'associations' do
    it 'inherits from quote' do
      expect(Company.superclass).to eq(Quote)
    end
  end
end
