# frozen_string_literal: true

class Quote < ApplicationRecord
  belongs_to :exchange
  belongs_to :sector
  # has_many :financials
  has_many :ratios
  # has_many :indicators

  has_many :balance_sheets, as: :financial_statementable, dependent: :destroy
  has_many :profit_and_loss_statements, as: :financial_statementable, dependent: :destroy
  has_many :cash_flows, as: :financial_statementable, dependent: :destroy
  has_many :quote_prices, dependent: :destroy
  has_and_belongs_to_many :peers, join_table: :quotes_peers
  has_many :dividends, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :shareholding_patterns

  validates :name, presence: true
  validates :ticker, presence: true, uniqueness: true
  validates :exchange_id, presence: true
  validates :beta, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, allow_nil: true
  validates :dividend_yield, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :price_to_earnings_ratio, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
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

  def current_price
    quote_prices.order(created_at: :desc).first&.price
  end
end
