# frozen_string_literal: true

# == Schema Information
#
# Table name: cash_flows
#
#  id                                  :integer          not null, primary key
#  accounts_payable                    :decimal(, )
#  accounts_receivable                 :decimal(, )
#  acquisitions_and_disposals          :decimal(, )
#  capital_expenditures                :decimal(, )
#  cash_from_financing_activities      :decimal(, )
#  cash_from_investing_activities      :decimal(, )
#  cash_from_operating_activities      :decimal(, )
#  change_in_cash_and_cash_equivalents :decimal(, )
#  change_in_working_capital           :decimal(, )
#  deferred_income_taxes               :decimal(, )
#  depreciation_and_amortization       :decimal(, )
#  dividend_payments                   :decimal(, )
#  effect_of_exchange_rate_changes     :decimal(, )
#  fiscal_period                       :string
#  fiscal_quarter                      :integer
#  fiscal_year                         :integer
#  inventory                           :decimal(, )
#  investment_purchases_and_sales      :decimal(, )
#  issue_of_capital_stock              :decimal(, )
#  net_cash_from_financing_activities  :decimal(, )
#  net_cash_from_investing_activities  :decimal(, )
#  net_cash_from_operating_activities  :decimal(, )
#  net_change_in_debt                  :decimal(, )
#  net_income                          :decimal(, )
#  other_financing_activities          :decimal(, )
#  other_working_capital               :decimal(, )
#  report_type                         :string
#  repurchase_of_capital_stock         :decimal(, )
#  stock_based_compensation            :decimal(, )
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  quote_id                            :integer          not null
#
# Indexes
#
#  index_cash_flows_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class CashFlow < ApplicationRecord
  validates :fiscal_period, presence: true
  validates :cash_from_operating_activities, presence: true, numericality: true
  validates :cash_from_investing_activities, presence: true, numericality: true
  validates :cash_from_financing_activities, presence: true, numericality: true
  # validates :effect_of_exchange_rate_changes, presence: true, numericality: true
  # validates :change_in_cash_and_cash_equivalents, presence: true, numericality: true
  validates :quote_id, presence: true

  belongs_to :quote
end
