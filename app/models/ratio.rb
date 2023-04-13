# frozen_string_literal: true

# == Schema Information
#
# Table name: ratios
#
#  id                                           :integer          not null, primary key
#  asset_turnover_ttm                           :float
#  capital_expenditure_coverage_ratio_ttm       :float
#  cash_conversion_cycle_ttm                    :float
#  cash_flow_coverage_ratios_ttm                :float
#  cash_flow_to_debt_ratio_ttm                  :float
#  cash_per_share_ttm                           :float
#  cash_ratio_ttm                               :float
#  company_equity_multiplier_ttm                :float
#  current_ratio_ttm                            :float
#  days_of_inventory_outstanding_ttm            :float
#  days_of_payables_outstanding_ttm             :float
#  days_of_sales_outstanding_ttm                :float
#  debt_equity_ratio_ttm                        :float
#  debt_ratio_ttm                               :float
#  dividend_paid_and_capex_coverage_ratio_ttm   :float
#  dividend_per_share_ttm                       :float
#  dividend_yield_percentage_ttm                :float
#  dividend_yield_ttm                           :float
#  ebit_per_revenue_ttm                         :float
#  ebt_per_ebit_ttm                             :float
#  effective_tax_rate_ttm                       :float
#  enterprise_value_multiple_ttm                :float
#  fixed_asset_turnover_ttm                     :float
#  free_cash_flow_operating_cash_flow_ratio_ttm :float
#  free_cash_flow_per_share_ttm                 :float
#  gross_profit_margin_ttm                      :float
#  interest_coverage_ttm                        :float
#  inventory_turnover_ttm                       :float
#  long_term_debt_to_capitalization_ttm         :float
#  name                                         :string
#  net_income_per_ebtttm                        :float
#  net_profit_margin_ttm                        :float
#  operating_cash_flow_per_share_ttm            :float
#  operating_cash_flow_sales_ratio_ttm          :float
#  operating_cycle_ttm                          :float
#  operating_profit_margin_ttm                  :float
#  payables_turnover_ttm                        :float
#  payout_ratio_ttm                             :float
#  pe_ratio_ttm                                 :float
#  peg_ratio_ttm                                :float
#  pretax_profit_margin_ttm                     :float
#  price_book_value_ratio_ttm                   :float
#  price_cash_flow_ratio_ttm                    :float
#  price_earnings_ratio_ttm                     :float
#  price_earnings_to_growth_ratio_ttm           :float
#  price_fair_value_ttm                         :float
#  price_sales_ratio_ttm                        :float
#  price_to_book_ratio_ttm                      :float
#  price_to_free_cash_flows_ratio_ttm           :float
#  price_to_operating_cash_flows_ratio_ttm      :float
#  price_to_sales_ratio_ttm                     :float
#  quick_ratio_ttm                              :float
#  receivables_turnover_ttm                     :float
#  return_on_assets_ttm                         :float
#  return_on_capital_employed_ttm               :float
#  return_on_equity_ttm                         :float
#  short_term_coverage_ratios_ttm               :float
#  total_debt_to_capitalization_ttm             :float
#  value                                        :decimal(, )
#  year                                         :float
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  quote_id                                     :integer          not null
#
# Indexes
#
#  index_ratios_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class Ratio < ApplicationRecord
  belongs_to :quote

  # validates :name, presence: true
  # validates :value, presence: true

  # scope :by_name, ->(name) { where(name:) }
  # scope :by_company, ->(company_id) { where(company_id:) }

  def self.calculate_ratios(company_id)
    company = Company.find(company_id)

    # Calculate profitability ratios
    gross_profit_margin = (company.revenue - company.cost_of_goods_sold) / company.revenue.to_f
    net_profit_margin = company.net_income / company.revenue.to_f
    return_on_equity = company.net_income / company.shareholders_equity.to_f

    # Calculate liquidity ratios
    current_ratio = company.current_assets / company.current_liabilities.to_f
    quick_ratio = (company.current_assets - company.inventory) / company.current_liabilities.to_f

    # Create ratio records
    Ratio.create(name: 'Gross Profit Margin', value: gross_profit_margin, company_id: company.id)
    Ratio.create(name: 'Net Profit Margin', value: net_profit_margin, company_id: company.id)
    Ratio.create(name: 'Return on Equity', value: return_on_equity, company_id: company.id)
    Ratio.create(name: 'Current Ratio', value: current_ratio, company_id: company.id)
    Ratio.create(name: 'Quick Ratio', value: quick_ratio, company_id: company.id)
  end
end
