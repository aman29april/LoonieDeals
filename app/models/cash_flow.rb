# frozen_string_literal: true

# == Schema Information
#
# Table name: cash_flows
#
#  id                                                   :integer          not null, primary key
#  accepted_date                                        :datetime         default(NULL), not null
#  accounts_payables_cents                              :integer
#  accounts_receivables_cents                           :integer
#  acquisitions_net_cents                               :integer
#  calendar_year                                        :integer          not null
#  capital_expenditure_cents                            :integer
#  cash_at_beginning_of_period_cents                    :integer
#  cash_at_end_of_period_cents                          :integer
#  change_in_working_capital_cents                      :integer
#  cik                                                  :string
#  common_stock_issued_cents                            :integer
#  common_stock_repurchased_cents                       :integer
#  currency                                             :string           default("USD"), not null
#  date                                                 :date
#  debt_repayment_cents                                 :integer
#  deferred_income_tax_cents                            :integer
#  depreciation_and_amortization_cents                  :integer
#  dividends_paid_cents                                 :integer
#  effect_of_forex_changes_on_cash_cents                :integer
#  filling_date                                         :datetime         default(NULL), not null
#  final_link                                           :string
#  free_cash_flow_cents                                 :integer
#  inventory_cents                                      :integer
#  investments_in_property_plant_and_equipment_cents    :integer
#  link                                                 :string
#  net_cash_provided_by_operating_activities_cents      :integer
#  net_cash_used_for_investing_activites_cents          :integer
#  net_cash_used_provided_by_financing_activities_cents :integer
#  net_change_in_cash_cents                             :integer
#  net_income_cents                                     :integer
#  operating_cash_flow_cents                            :integer
#  other_financing_activites_cents                      :integer
#  other_investing_activites_cents                      :integer
#  other_non_cash_items_cents                           :integer
#  other_working_capital_cents                          :integer
#  period                                               :string
#  purchases_of_investments_cents                       :integer
#  sales_maturities_of_investments_cents                :integer
#  stock_based_compensation_cents                       :integer
#  created_at                                           :datetime         not null
#  updated_at                                           :datetime         not null
#  quote_id                                             :integer          not null
#
# Indexes
#
#  index_cash_flows_on_quote_id                               (quote_id)
#  index_cash_flows_on_quote_id_and_period_and_calendar_year  (quote_id,period,calendar_year) UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class CashFlow < ApplicationRecord
  include FinancialStatementHelper

  # validates :fiscal_year, presence: true
  # validates :cash_from_operating_activities, presence: true, numericality: true
  # validates :cash_from_investing_activities, presence: true, numericality: true
  # validates :cash_from_financing_activities, presence: true, numericality: true
  # validates :effect_of_exchange_rate_changes, presence: true, numericality: true
  # validates :change_in_cash_and_cash_equivalents, presence: true, numericality: true
  validates :quote_id, presence: true

  belongs_to :quote

  MAP = {
    net_income: { text: 'Net Income' },
    depreciation_and_amortization: { text: 'Depreciation And Amortization' },
    deferred_income_tax: { text: 'Deferred Income Tax' },
    stock_based_compensation: { text: 'Stock Based Compensation' },
    change_in_working_capital: { text: 'Change In Working Capital' },
    accounts_receivables: { text: 'Accounts Receivables' },
    inventory: { text: 'Inventory' },
    accounts_payables: { text: 'Accounts Payables' },
    other_working_capital: { text: 'Other Working Capital' },
    other_non_cash_items: { text: 'Other Non Cash Items' },
    net_cash_provided_by_operating_activities: { text: 'Net Cash Provided By Operating Activities' },
    investments_in_property_plant_and_equipment: { text: 'Investments In Property Plant And Equipment' },
    acquisitions_net: { text: 'Acquisitions Net' },
    purchases_of_investments: { text: 'Purchases Of Investments' },
    sales_maturities_of_investments: { text: 'Sales Maturities Of Investments' },
    other_investing_activites: { text: 'Other Investing Activites' },
    net_cash_used_for_investing_activites: { text: 'Net Cash Used For Investing Activites' },
    debt_repayment: { text: 'Debt Repayment' },
    common_stock_issued: { text: 'Common Stock Issued' },
    common_stock_repurchased: { text: 'Common Stock Repurchased' },
    dividends_paid: { text: 'Dividends Paid' },
    other_financing_activites: { text: 'Other Financing Activites' },
    net_cash_used_provided_by_financing_activities: { text: 'Net Cash Used Provided By Financing Activities' },
    effect_of_forex_changes_on_cash: { text: 'Effect Of Forex Changes On Cash' },
    net_change_in_cash: { text: 'Net Change In Cash' },
    cash_at_end_of_period: { text: 'Cash At End Of Period' },
    cash_at_beginning_of_period: { text: 'Cash At Beginning Of Period' },
    operating_cash_flow: { text: 'Operating Cash Flow' },
    capital_expenditure: { text: 'Capital Expenditure' },
    free_cash_flow: { text: 'Free Cash Flow' }
  }.freeze

  def map
    MAP
  end
  monetize :net_income_cents,
           :depreciation_and_amortization_cents,
           :deferred_income_tax_cents,
           :stock_based_compensation_cents,
           :change_in_working_capital_cents,
           :accounts_receivables_cents,
           :inventory_cents,
           :accounts_payables_cents,
           :other_working_capital_cents,
           :other_non_cash_items_cents,
           :net_cash_provided_by_operating_activities_cents,
           :investments_in_property_plant_and_equipment_cents,
           :acquisitions_net_cents,
           :purchases_of_investments_cents,
           :sales_maturities_of_investments_cents,
           :other_investing_activites_cents,
           :net_cash_used_for_investing_activites_cents,
           :debt_repayment_cents,
           :common_stock_issued_cents,
           :common_stock_repurchased_cents,
           :dividends_paid_cents,
           :other_financing_activites_cents,
           :net_cash_used_provided_by_financing_activities_cents,
           :effect_of_forex_changes_on_cash_cents,
           :net_change_in_cash_cents,
           :cash_at_end_of_period_cents,
           :cash_at_beginning_of_period_cents,
           :operating_cash_flow_cents,
           :capital_expenditure_cents,
           :free_cash_flow_cents, with_model_currency: :currency
end
