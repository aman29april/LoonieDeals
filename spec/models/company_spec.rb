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
