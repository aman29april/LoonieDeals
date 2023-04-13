# frozen_string_literal: true

class CreateRatios < ActiveRecord::Migration[7.0]
  def change
    create_table :ratios do |t|
      t.string :name
      t.decimal :value
      t.float :year
      t.references :quote, null: false, foreign_key: true

      t.float :dividend_yield_percentage_ttm
      t.float :pe_ratio_ttm
      t.float :peg_ratio_ttm
      t.float :payout_ratio_ttm
      t.float :current_ratio_ttm
      t.float :quick_ratio_ttm
      t.float :cash_ratio_ttm
      t.float :days_of_sales_outstanding_ttm
      t.float :days_of_inventory_outstanding_ttm
      t.float :operating_cycle_ttm
      t.float :days_of_payables_outstanding_ttm
      t.float :cash_conversion_cycle_ttm
      t.float :gross_profit_margin_ttm
      t.float :operating_profit_margin_ttm
      t.float :pretax_profit_margin_ttm
      t.float :net_profit_margin_ttm
      t.float :effective_tax_rate_ttm
      t.float :return_on_assets_ttm
      t.float :return_on_equity_ttm
      t.float :return_on_capital_employed_ttm
      t.float :net_income_per_ebtttm
      t.float :ebt_per_ebit_ttm
      t.float :ebit_per_revenue_ttm
      t.float :debt_ratio_ttm
      t.float :debt_equity_ratio_ttm
      t.float :long_term_debt_to_capitalization_ttm
      t.float :total_debt_to_capitalization_ttm
      t.float :interest_coverage_ttm
      t.float :cash_flow_to_debt_ratio_ttm
      t.float :company_equity_multiplier_ttm
      t.float :receivables_turnover_ttm
      t.float :payables_turnover_ttm
      t.float :inventory_turnover_ttm
      t.float :fixed_asset_turnover_ttm
      t.float :asset_turnover_ttm
      t.float :operating_cash_flow_per_share_ttm
      t.float :free_cash_flow_per_share_ttm
      t.float :cash_per_share_ttm
      t.float :operating_cash_flow_sales_ratio_ttm
      t.float :free_cash_flow_operating_cash_flow_ratio_ttm
      t.float :cash_flow_coverage_ratios_ttm
      t.float :short_term_coverage_ratios_ttm
      t.float :capital_expenditure_coverage_ratio_ttm
      t.float :dividend_paid_and_capex_coverage_ratio_ttm
      t.float :price_book_value_ratio_ttm
      t.float :price_to_book_ratio_ttm
      t.float :price_to_sales_ratio_ttm
      t.float :price_earnings_ratio_ttm
      t.float :price_to_free_cash_flows_ratio_ttm
      t.float :price_to_operating_cash_flows_ratio_ttm
      t.float :price_cash_flow_ratio_ttm
      t.float :price_earnings_to_growth_ratio_ttm
      t.float :price_sales_ratio_ttm
      t.float :dividend_yield_ttm
      t.float :enterprise_value_multiple_ttm
      t.float :price_fair_value_ttm
      t.float :dividend_per_share_ttm

      t.timestamps
    end
  end
end
