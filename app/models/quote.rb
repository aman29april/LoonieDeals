# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id                                                                               :integer          not null, primary key
#  #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x000000011b7d9260> :date
#  address                                                                          :string
#  beta                                                                             :decimal(, )
#  ceo                                                                              :string
#  cik                                                                              :string
#  city                                                                             :string
#  close_price_cents                                                                :integer          default(0), not null
#  country                                                                          :string
#  currency                                                                         :string           default("USD"), not null
#  cusip                                                                            :string
#  dcf                                                                              :decimal(, )
#  dcf_diff                                                                         :decimal(, )
#  description                                                                      :text
#  dividend_yield                                                                   :decimal(, )      default(0.0)
#  earnings_per_share                                                               :decimal(, )
#  exchange_url                                                                     :string
#  expense_ratio                                                                    :decimal(, )      default(0.0)
#  forward_pe_ratio                                                                 :decimal(, )
#  founded                                                                          :date
#  full_time_employees                                                              :integer
#  fund_family                                                                      :string
#  image                                                                            :string
#  ipo_date                                                                         :date
#  ipo_year                                                                         :integer
#  is_etf                                                                           :boolean
#  is_fund                                                                          :boolean
#  isin                                                                             :string
#  l52w_high_cents                                                                  :integer          default(0), not null
#  l52w_low_cents                                                                   :integer          default(0), not null
#  last_div                                                                         :float
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
#  industry_id                                                                      :integer
#  sector_id                                                                        :integer
#
# Indexes
#
#  index_quotes_on_exchange_id  (exchange_id)
#  index_quotes_on_industry_id  (industry_id)
#  index_quotes_on_sector_id    (sector_id)
#
# Foreign Keys
#
#  exchange_id  (exchange_id => exchanges.id)
#  industry_id  (industry_id => industries.id)
#  sector_id    (sector_id => sectors.id)
#
class Quote < ApplicationRecord
  extend FriendlyId

  friendly_id :ticker

  belongs_to :exchange
  belongs_to :sector
  belongs_to :industry
  # has_many :financials
  has_many :ratios
  # has_many :indicators

  # as: :financial_statementable,
  has_many :balance_sheets, dependent: :destroy
  has_many :profit_and_loss_statements, dependent: :destroy
  has_many :cash_flows, dependent: :destroy
  has_many :income_statements, dependent: :destroy
  has_many :daily_prices, dependent: :destroy
  has_many :monthly_prices, dependent: :destroy
  has_many :yearly_prices, dependent: :destroy
  has_many :split_histories, dependent: :destroy
  has_and_belongs_to_many :peers, join_table: :quotes_peers
  has_many :dividends, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :shareholding_patterns

  validates :name, presence: true
  validates :ticker, presence: true, uniqueness: true
  validates :exchange_id, presence: true
  validates :beta, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
  validates :dividend_yield, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :pe_ratio, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :earnings_per_share, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scope to find all companies with a given exchange code
  scope :by_exchange_code, ->(exchange_code) { joins(:exchange).where('exchanges.code = ?', exchange_code) }

  # Scope to find all companies in a given sector
  scope :by_sector, ->(sector_id) { where(sector_id:) }

  # Scope to find all companies with a given market capitalization range
  scope :by_market_cap, lambda { |min_market_cap, max_market_cap|
                          where(market_capitalization: min_market_cap..max_market_cap)
                        }

  # Scope to find all companies with a given price-to-earnings ratio range
  scope :by_pe_ratio, ->(min_pe_ratio, max_pe_ratio) { where(pe_ratio: min_pe_ratio..max_pe_ratio) }

  # Scope to find all companies with a positive net income in the most recent quarter
  scope :profitable, lambda {
                       joins(:profit_and_loss_statements).where('profit_and_loss_statements.net_income > 0').order('profit_and_loss_statements.date DESC')
                     }

  # Scope to find all companies with a debt-to-equity ratio below a certain threshold
  scope :low_debt_to_equity, lambda { |max_debt_to_equity|
                               joins(:balance_sheets).where('balance_sheets.total_liabilities / balance_sheets.total_equity < ?', max_debt_to_equity).order('balance_sheets.date DESC')
                             }

  monetize :price_cents,
           :l52w_high_cents, :l52w_low_cents,
           :open_price_cents, :close_price_cents,
           allow_nil: true, with_model_currency: :currency

  def current_price
    daily_prices.order(created_at: :desc).first&.price
  end

  def week52_range
    "#{l52w_low.format}-#{l52w_high.format}"
  end

  def day_range
    "#{open_price.format}-#{close_price.format}"
  end
end
