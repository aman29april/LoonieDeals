# frozen_string_literal: true

# == Schema Information
#
# Table name: balance_sheets
#
#  id                                                :integer          not null, primary key
#  accepted_date                                     :datetime
#  account_payables_cents                            :integer
#  accumulated_other_comprehensive_income_loss_cents :integer
#  calendar_year                                     :integer
#  capital_lease_obligations_cents                   :integer
#  cash_and_cash_equivalents_cents                   :integer
#  cash_and_short_term_investments_cents             :integer
#  cik                                               :string
#  common_stock_cents                                :integer
#  currency                                          :string           default("USD"), not null
#  date                                              :date
#  deferred_revenue_cents                            :integer
#  deferred_revenue_non_current_cents                :integer
#  deferred_tax_liabilities_non_current_cents        :integer
#  filling_date                                      :datetime
#  final_link                                        :string
#  goodwill_and_intangible_assets_cents              :integer
#  goodwill_cents                                    :integer
#  intangible_assets_cents                           :integer
#  inventory_cents                                   :integer
#  link                                              :string
#  long_term_debt_cents                              :integer
#  long_term_investments_cents                       :integer
#  minority_interest_cents                           :integer
#  net_debt_cents                                    :integer
#  net_receivables_cents                             :integer
#  other_assets_cents                                :integer
#  other_current_assets_cents                        :integer
#  other_current_liabilities_cents                   :integer
#  other_liabilities_cents                           :integer
#  other_non_current_assets_cents                    :integer
#  other_non_current_liabilities_cents               :integer
#  othertotal_stockholders_equity_cents              :integer
#  period                                            :string
#  preferred_stock_cents                             :integer
#  property_plant_equipment_net_cents                :integer
#  retained_earnings_cents                           :integer
#  short_term_debt_cents                             :integer
#  short_term_investments_cents                      :integer
#  tax_assets_cents                                  :integer
#  tax_payables_cents                                :integer
#  total_assets_cents                                :integer
#  total_current_assets_cents                        :integer
#  total_current_liabilities_cents                   :integer
#  total_debt_cents                                  :integer
#  total_equity_cents                                :integer
#  total_investments_cents                           :integer
#  total_liabilities_and_stockholders_equity_cents   :integer
#  total_liabilities_and_total_equity_cents          :integer
#  total_liabilities_cents                           :integer
#  total_non_current_assets_cents                    :integer
#  total_non_current_liabilities_cents               :integer
#  total_stockholders_equity_cents                   :integer
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#  quote_id                                          :integer          not null
#
# Indexes
#
#  index_balance_sheets_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class BalanceSheet < ApplicationRecord
  # include ActionView::Helper
  include FinancialStatementHelper

  MAP = {
    date: { text: 'Date' },

    # cik: { text: 'Cik' },
    # filling_date: { text: 'Filling Date' },
    # accepted_date: { text: 'Accepted Date' },
    calendar_year: { text: 'Calendar Year' },
    period: { text: 'Period', format: :as_it_is },
    cash_and_cash_equivalents: { text: 'Cash And Cash Equivalents' },
    short_term_investments: { text: 'Short Term Investments' },
    cash_and_short_term_investments: { text: 'Cash And Short Term Investments' },
    net_receivables: { text: 'Net Receivables' },
    inventory: { text: 'Inventory' },
    other_current_assets: { text: 'Other Current Assets' },
    total_current_assets: { text: 'Total Current Assets' },
    property_plant_equipment_net: { text: 'Property Plant Equipment Net' },
    goodwill: { text: 'Goodwill' },
    intangible_assets: { text: 'Intangible Assets' },
    goodwill_and_intangible_assets: { text: 'Goodwill And Intangible Assets' },
    long_term_investments: { text: 'Long Term Investments' },
    tax_assets: { text: 'Tax Assets' },
    other_non_current_assets: { text: 'Other Non Current Assets' },
    total_non_current_assets: { text: 'Total Non Current Assets' },
    other_assets: { text: 'Other Assets' },
    total_assets: { text: 'Total Assets' },
    account_payables: { text: 'Account Payables' },
    short_term_debt: { text: 'Short Term Debt' },
    tax_payables: { text: 'Tax Payables' },
    deferred_revenue: { text: 'Deferred Revenue' },
    other_current_liabilities: { text: 'Other Current Liabilities' },
    total_current_liabilities: { text: 'Total Current Liabilities' },
    long_term_debt: { text: 'Long Term Debt' },
    deferred_revenue_non_current: { text: 'Deferred Revenue Non Current' },
    deferred_tax_liabilities_non_current: { text: 'Deferred Tax Liabilities Non Current' },
    other_non_current_liabilities: { text: 'Other Non Current Liabilities' },
    total_non_current_liabilities: { text: 'Total Non Current Liabilities' },
    other_liabilities: { text: 'Other Liabilities' },
    capital_lease_obligations: { text: 'Capital Lease Obligations' },
    total_liabilities: { text: 'Total Liabilities' },
    preferred_stock: { text: 'Preferred Stock' },
    common_stock: { text: 'Common Stock' },
    retained_earnings: { text: 'Retained Earnings' },
    accumulated_other_comprehensive_income_loss: { text: 'Accumulated Other Comprehensive Income Loss' },
    othertotal_stockholders_equity: { text: 'Othertotal Stockholders Equity' },
    total_stockholders_equity: { text: 'Total Stockholders Equity' },
    total_equity: { text: 'Total Equity' },
    total_liabilities_and_stockholders_equity: { text: 'Total Liabilities And Stockholders Equity' },
    minority_interest: { text: 'Minority Interest' },
    total_liabilities_and_total_equity: { text: 'Total Liabilities And Total Equity' },
    total_investments: { text: 'Total Investments' },
    total_debt: { text: 'Total Debt' },
    net_debt: { text: 'Net Debt' }
    # link: { text: 'Link', format: :as_it_is },
    # final_link: { text: 'Final Link', format: :as_it_is }

  }.freeze

  COLS = [
    SHORT_TERM_ASSETS = [
      'Cash and Cash Equivalents',
      'Short-Term Investments',
      'Cash & Short-Term Investments',
      'Net Receivables',
      'Inventory',
      'Other Current Assets',
      'Total Current Assets'
    ].freeze,

    LONG_TERM_ASSETS = [
      'PP&E',
      'Goodwill',
      'Intangible Assets',
      'Investments',
      'Tax Assets',
      'Other Non-Current Assets',
      'Total Non-Current Assets',
      'Total Assets'
    ].freeze,

    CURRENT_LIABILITIES = [
      'Accounts Payable',
      'Short-Term Debt',
      'Tax Payable',
      'Deferred Revenue',
      'Other Current Liabilities',
      'Total Current Liabilities'
    ].freeze,

    LONG_TERM_LIABILITIES = [
      'Long-Term Debt',
      'Deferred Revenue',
      'Deferred Tax Liabilities',
      'Other Non-Current Liabilities',
      'Total Non-Current Liabilities',
      'Total Liabilities'
    ].freeze,

    EQUITY = [
      'Retained Earnings',
      'Other Total Stockhold. Equity',
      'Total Stockholders Equity'
    ].freeze
  ].freeze
  # validates :fiscal_year, presence: true
  # validates :total_assets, presence: true, numericality: true
  # validates :total_liabilities, presence: true, numericality: true
  # validates :total_equity, presence: true, numericality: true
  validates :quote_id, presence: true

  belongs_to :quote

  monetize :cash_and_cash_equivalents_cents,
           :short_term_investments_cents,
           :cash_and_short_term_investments_cents,
           :net_receivables_cents,
           :inventory_cents,
           :other_current_assets_cents,
           :total_current_assets_cents,
           :property_plant_equipment_net_cents,
           :goodwill_cents,
           :intangible_assets_cents,
           :goodwill_and_intangible_assets_cents,
           :long_term_investments_cents,
           :tax_assets_cents,
           :other_non_current_assets_cents,
           :total_non_current_assets_cents,
           :other_assets_cents,
           :total_assets_cents,
           :account_payables_cents,
           :short_term_debt_cents,
           :tax_payables_cents,
           :deferred_revenue_cents,
           :other_current_liabilities_cents,
           :total_current_liabilities_cents,
           :long_term_debt_cents,
           :deferred_revenue_non_current_cents,
           :deferred_tax_liabilities_non_current_cents,
           :other_non_current_liabilities_cents,
           :total_non_current_liabilities_cents,
           :other_liabilities_cents,
           :capital_lease_obligations_cents,
           :total_liabilities_cents,
           :preferred_stock_cents,
           :common_stock_cents,
           :retained_earnings_cents,
           :accumulated_other_comprehensive_income_loss_cents,
           :othertotal_stockholders_equity_cents,
           :total_stockholders_equity_cents,
           :total_equity_cents,
           :total_liabilities_and_stockholders_equity_cents,
           :minority_interest_cents,
           :total_liabilities_and_total_equity_cents,
           :total_investments_cents,
           :total_debt_cents,
           :net_debt_cents,
           with_model_currency: :currency, allow_nil: true

  def map
    MAP
  end
end
