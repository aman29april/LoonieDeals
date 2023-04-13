# frozen_string_literal: true

# == Schema Information
#
# Table name: financial_statements
#
#  id                                                   :integer          not null, primary key
#  accepted_date                                        :datetime
#  account_payables_cents                               :integer
#  accounts_payables_cents                              :integer
#  accounts_receivables_cents                           :integer
#  accumulated_other_comprehensive_income_loss_cents    :integer
#  acquisitions_net_cents                               :integer
#  calendar_year                                        :integer
#  capital_expenditure_cents                            :integer
#  capital_lease_obligations_cents                      :integer
#  cash_and_cash_equivalents_cents                      :integer
#  cash_and_short_term_investments_cents                :integer
#  cash_at_beginning_of_period_cents                    :integer
#  cash_at_end_of_period_cents                          :integer
#  change_in_working_capital_cents                      :integer
#  cik                                                  :string
#  common_stock_cents                                   :integer
#  common_stock_issued_cents                            :integer
#  common_stock_repurchased_cents                       :integer
#  cost_and_expenses_cents                              :integer
#  cost_of_revenue_cents                                :integer
#  currency                                             :string           default("USD"), not null
#  date                                                 :date
#  debt_repayment_cents                                 :integer
#  deferred_income_tax_cents                            :integer
#  deferred_revenue_cents                               :integer
#  deferred_revenue_non_current_cents                   :integer
#  deferred_tax_liabilities_non_current_cents           :integer
#  depreciation_and_amortization_cents                  :integer
#  dividends_paid_cents                                 :integer
#  ebitda_cents                                         :integer
#  ebitdaratio                                          :float
#  effect_of_forex_changes_on_cash_cents                :integer
#  eps_cents                                            :integer
#  epsdiluted_cents                                     :integer
#  filling_date                                         :datetime
#  final_link                                           :string
#  free_cash_flow_cents                                 :integer
#  general_and_administrative_expenses_cents            :integer
#  goodwill_and_intangible_assets_cents                 :integer
#  goodwill_cents                                       :integer
#  gross_profit_cents                                   :integer
#  gross_profit_ratio                                   :float
#  income_before_tax_cents                              :integer
#  income_before_tax_ratio                              :float
#  income_tax_expense_cents                             :integer
#  intangible_assets_cents                              :integer
#  interest_expense_cents                               :integer
#  interest_income_cents                                :integer
#  inventory_cents                                      :integer
#  investments_in_property_plant_and_equipment_cents    :integer
#  link                                                 :string
#  long_term_debt_cents                                 :integer
#  long_term_investments_cents                          :integer
#  minority_interest_cents                              :integer
#  net_cash_provided_by_operating_activities_cents      :integer
#  net_cash_used_for_investing_activites_cents          :integer
#  net_cash_used_provided_by_financing_activities_cents :integer
#  net_change_in_cash_cents                             :integer
#  net_debt_cents                                       :integer
#  net_income_cents                                     :integer
#  net_income_ratio                                     :float
#  net_receivables_cents                                :integer
#  operating_cash_flow_cents                            :integer
#  operating_expenses_cents                             :integer
#  operating_income_cents                               :integer
#  operating_income_ratio                               :float
#  other_assets_cents                                   :integer
#  other_current_assets_cents                           :integer
#  other_current_liabilities_cents                      :integer
#  other_expenses_cents                                 :integer
#  other_financing_activites_cents                      :integer
#  other_investing_activites_cents                      :integer
#  other_liabilities_cents                              :integer
#  other_non_cash_items_cents                           :integer
#  other_non_current_assets_cents                       :integer
#  other_non_current_liabilities_cents                  :integer
#  other_working_capital_cents                          :integer
#  othertotal_stockholders_equity_cents                 :integer
#  period                                               :string
#  preferred_stock_cents                                :integer
#  property_plant_equipment_net_cents                   :integer
#  purchases_of_investments_cents                       :integer
#  research_and_development_expenses_cents              :integer
#  retained_earnings_cents                              :integer
#  revenue_cents                                        :integer
#  sales_maturities_of_investments_cents                :integer
#  selling_and_marketing_expenses_cents                 :integer
#  selling_general_and_administrative_expenses_cents    :integer
#  short_term_debt_cents                                :integer
#  short_term_investments_cents                         :integer
#  stock_based_compensation_cents                       :integer
#  tax_assets_cents                                     :integer
#  tax_payables_cents                                   :integer
#  total_assets_cents                                   :integer
#  total_current_assets_cents                           :integer
#  total_current_liabilities_cents                      :integer
#  total_debt_cents                                     :integer
#  total_equity_cents                                   :integer
#  total_investments_cents                              :integer
#  total_liabilities_and_stockholders_equity_cents      :integer
#  total_liabilities_and_total_equity_cents             :integer
#  total_liabilities_cents                              :integer
#  total_non_current_assets_cents                       :integer
#  total_non_current_liabilities_cents                  :integer
#  total_other_income_expenses_net_cents                :integer
#  total_stockholders_equity_cents                      :integer
#  weighted_average_shs_out_cents                       :integer
#  weighted_average_shs_out_dil_cents                   :integer
#  created_at                                           :datetime         not null
#  updated_at                                           :datetime         not null
#  quote_id                                             :integer          not null
#
# Indexes
#
#  index_financial_statements_on_quote_id           (quote_id)
#  index_financial_statements_on_quote_period_year  (quote_id,period,calendar_year) UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class FinancialStatement < ApplicationRecord
  include FinancialStatementHelper

  # validates :fiscal_year, presence: true
  # validates :total_revenue, presence: true, numericality: true
  # validates :cost_of_revenue, presence: true, numericality: true
  # validates :gross_profit, presence: true, numericality: true
  # validates :operating_expenses, presence: true, numericality: true
  # validates :operating_income, presence: true, numericality: true
  # validates :net_income, presence: true, numericality: true
  validates :quote_id, presence: true
  belongs_to :quote

  MAP = {
    revenue: { text: 'Revenue' },
    cost_of_revenue: { text: 'Cost Of Revenue' },
    gross_profit: { text: 'Gross Profit' },
    gross_profit_ratio: { text: 'Gross Profit Ratio' },
    research_and_development_expenses: { text: 'Research And Development Expenses' },
    general_and_administrative_expenses: { text: 'General And Administrative Expenses' },
    selling_and_marketing_expenses: { text: 'Selling And Marketing Expenses' },
    selling_general_and_administrative_expenses: { text: 'Selling General And Administrative Expenses' },
    other_expenses: { text: 'Other Expenses' },
    operating_expenses: { text: 'Operating Expenses' },
    cost_and_expenses: { text: 'Cost And Expenses' },
    interest_income: { text: 'Interest Income' },
    interest_expense: { text: 'Interest Expense' },
    depreciation_and_amortization: { text: 'Depreciation And Amortization' },
    ebitda: { text: 'Ebitda' },
    ebitdaratio: { text: 'Ebitdaratio' },
    operating_income: { text: 'Operating Income' },
    operating_income_ratio: { text: 'Operating Income Ratio' },
    total_other_income_expenses_net: { text: 'Total Other Income Expenses Net' },
    income_before_tax: { text: 'Income Before Tax' },
    income_before_tax_ratio: { text: 'Income Before Tax Ratio' },
    income_tax_expense: { text: 'Income Tax Expense' },
    net_income: { text: 'Net Income' },
    net_income_ratio: { text: 'Net Income Ratio' },
    eps: { text: 'Eps' },
    epsdiluted: { text: 'Epsdiluted' },
    weighted_average_shs_out: { text: 'Weighted Average Shs Out' },
    weighted_average_shs_out_dil: { text: 'Weighted Average Shs Out Dil' },
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
    net_debt: { text: 'Net Debt' },
    deferred_income_tax: { text: 'Deferred Income Tax' },
    stock_based_compensation: { text: 'Stock Based Compensation' },
    change_in_working_capital: { text: 'Change In Working Capital' },
    accounts_receivables: { text: 'Accounts Receivables' },
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
    # link: {text: 'Link' },
    # final_link: {text: 'Final Link' },
  }

  monetize :revenue_cents,
           :cost_of_revenue_cents,
           :gross_profit_cents,
           :research_and_development_expenses_cents,
           :general_and_administrative_expenses_cents,
           :selling_and_marketing_expenses_cents,
           :selling_general_and_administrative_expenses_cents,
           :other_expenses_cents,
           :operating_expenses_cents,
           :cost_and_expenses_cents,
           :interest_income_cents,
           :interest_expense_cents,
           :depreciation_and_amortization_cents,
           :ebitda_cents,
           :operating_income_cents,
           :total_other_income_expenses_net_cents,
           :income_before_tax_cents,
           :income_tax_expense_cents,
           :net_income_cents,
           :eps_cents,
           :epsdiluted_cents,
           :weighted_average_shs_out_cents,
           :weighted_average_shs_out_dil_cents,
           :cash_and_cash_equivalents_cents,
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
           :deferred_income_tax_cents,
           :stock_based_compensation_cents,
           :change_in_working_capital_cents,
           :accounts_receivables_cents,
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

  def map
    MAP
  end
end
