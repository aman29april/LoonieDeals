# frozen_string_literal: true

# == Schema Information
#
# Table name: income_statements
#
#  id                                                :integer          not null, primary key
#  accepted_date                                     :date             default(NULL), not null
#  calendar_year                                     :integer          not null
#  cik                                               :string
#  cost_and_expenses_cents                           :integer
#  cost_of_revenue_cents                             :integer
#  currency                                          :string           default("USD"), not null
#  date                                              :date
#  depreciation_and_amortization_cents               :integer
#  ebitda_cents                                      :integer
#  ebitdaratio                                       :float
#  eps_cents                                         :integer
#  epsdiluted_cents                                  :integer
#  filling_date                                      :date             default(NULL), not null
#  final_link                                        :string
#  general_and_administrative_expenses_cents         :integer
#  gross_profit_cents                                :integer
#  gross_profit_ratio                                :float
#  income_before_tax_cents                           :integer
#  income_before_tax_ratio                           :float
#  income_tax_expense_cents                          :integer
#  interest_expense_cents                            :integer
#  interest_income_cents                             :integer
#  link                                              :string
#  net_income_cents                                  :integer
#  net_income_ratio                                  :float
#  operating_expenses_cents                          :integer
#  operating_income_cents                            :integer
#  operating_income_ratio                            :float
#  other_expenses_cents                              :integer
#  period                                            :string
#  research_and_development_expenses_cents           :integer
#  revenue_cents                                     :integer
#  selling_and_marketing_expenses_cents              :integer
#  selling_general_and_administrative_expenses_cents :integer
#  total_other_income_expenses_net_cents             :integer
#  weighted_average_shs_out_cents                    :integer
#  weighted_average_shs_out_dil_cents                :integer
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#  quote_id                                          :integer          not null
#
# Indexes
#
#  index_income_statements_on_quote_id                               (quote_id)
#  index_income_statements_on_quote_id_and_period_and_calendar_year  (quote_id,period,calendar_year) UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class IncomeStatement < ApplicationRecord
  include FinancialStatementHelper

  validates :quote_id, presence: true

  belongs_to :quote

  MAP = {
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
    weighted_average_shs_out_dil: { text: 'Weighted Average Shs Out Dil' }
  }.freeze

  monetize :revenue_cents, :cost_of_revenue_cents,
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
           with_model_currency: :currency

  def map
    MAP
  end
end
