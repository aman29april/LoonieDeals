# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id                                                                               :integer          not null, primary key
#  #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x0000000113884a78> :date
#  address                                                                          :string
#  beta                                                                             :decimal(, )
#  ceo                                                                              :string
#  city                                                                             :string
#  close_price_cents                                                                :integer          default(0), not null
#  country                                                                          :string
#  currency                                                                         :string           default("USD"), not null
#  description                                                                      :text
#  dividend_yield                                                                   :decimal(, )      default(0.0)
#  earnings_per_share                                                               :decimal(, )
#  employees                                                                        :integer
#  exchange_url                                                                     :string
#  expense_ratio                                                                    :decimal(, )      default(0.0)
#  forward_pe_ratio                                                                 :decimal(, )
#  founded                                                                          :date
#  fund_family                                                                      :string
#  industry                                                                         :string
#  ipo_year                                                                         :integer
#  l52w_high_cents                                                                  :integer          default(0), not null
#  l52w_low_cents                                                                   :integer          default(0), not null
#  market_cap                                                                       :integer
#  name                                                                             :string
#  net_assets                                                                       :float
#  open_price_cents                                                                 :integer          default(0), not null
#  pe_ratio                                                                         :decimal(, )
#  phone                                                                            :string
#  price_cents                                                                      :integer          default(0), not null
#  price_to_book_ratio                                                              :decimal(, )
#  roce                                                                             :decimal(, )
#  sector                                                                           :string
#  state                                                                            :string
#  ticker                                                                           :string
#  type                                                                             :string
#  upcoming_earnings                                                                :date
#  volume                                                                           :integer
#  website                                                                          :string
#  zip                                                                              :string
#  created_at                                                                       :datetime         not null
#  updated_at                                                                       :datetime         not null
#  exchange_id                                                                      :integer          not null
#  sector_id                                                                        :integer          not null
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
