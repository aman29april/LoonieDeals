# frozen_string_literal: true

# == Schema Information
#
# Table name: income_statments
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
#  index_income_statments_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :income_statment do
  end
end
