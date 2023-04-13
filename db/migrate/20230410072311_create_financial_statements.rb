# frozen_string_literal: true

class CreateFinancialStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_statements do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :date
      t.datetime :filling_date
      t.datetime :accepted_date
      t.integer :calendar_year
      t.string :period
      t.string :cik
      t.string :currency, default: 'USD', null: false

      t.integer :revenue_cents
      t.integer :cost_of_revenue_cents
      t.integer :gross_profit_cents
      t.float :gross_profit_ratio
      t.integer :research_and_development_expenses_cents
      t.integer :general_and_administrative_expenses_cents
      t.integer :selling_and_marketing_expenses_cents
      t.integer :selling_general_and_administrative_expenses_cents
      t.integer :other_expenses_cents
      t.integer :operating_expenses_cents
      t.integer :cost_and_expenses_cents
      t.integer :interest_income_cents
      t.integer :interest_expense_cents
      t.integer :depreciation_and_amortization_cents
      t.integer :ebitda_cents
      t.float :ebitdaratio
      t.integer :operating_income_cents
      t.float :operating_income_ratio
      t.integer :total_other_income_expenses_net_cents
      t.integer :income_before_tax_cents
      t.float :income_before_tax_ratio
      t.integer :income_tax_expense_cents
      t.integer :net_income_cents
      t.float :net_income_ratio
      t.integer :eps_cents
      t.integer :epsdiluted_cents
      t.integer :weighted_average_shs_out_cents
      t.integer :weighted_average_shs_out_dil_cents
      t.integer :cash_and_cash_equivalents_cents
      t.integer :short_term_investments_cents
      t.integer :cash_and_short_term_investments_cents
      t.integer :net_receivables_cents
      t.integer :inventory_cents
      t.integer :other_current_assets_cents
      t.integer :total_current_assets_cents
      t.integer :property_plant_equipment_net_cents
      t.integer :goodwill_cents
      t.integer :intangible_assets_cents
      t.integer :goodwill_and_intangible_assets_cents
      t.integer :long_term_investments_cents
      t.integer :tax_assets_cents
      t.integer :other_non_current_assets_cents
      t.integer :total_non_current_assets_cents
      t.integer :other_assets_cents
      t.integer :total_assets_cents
      t.integer :account_payables_cents
      t.integer :short_term_debt_cents
      t.integer :tax_payables_cents
      t.integer :deferred_revenue_cents
      t.integer :other_current_liabilities_cents
      t.integer :total_current_liabilities_cents
      t.integer :long_term_debt_cents
      t.integer :deferred_revenue_non_current_cents
      t.integer :deferred_tax_liabilities_non_current_cents
      t.integer :other_non_current_liabilities_cents
      t.integer :total_non_current_liabilities_cents
      t.integer :other_liabilities_cents
      t.integer :capital_lease_obligations_cents
      t.integer :total_liabilities_cents
      t.integer :preferred_stock_cents
      t.integer :common_stock_cents
      t.integer :retained_earnings_cents
      t.integer :accumulated_other_comprehensive_income_loss_cents
      t.integer :othertotal_stockholders_equity_cents
      t.integer :total_stockholders_equity_cents
      t.integer :total_equity_cents
      t.integer :total_liabilities_and_stockholders_equity_cents
      t.integer :minority_interest_cents
      t.integer :total_liabilities_and_total_equity_cents
      t.integer :total_investments_cents
      t.integer :total_debt_cents
      t.integer :net_debt_cents
      t.integer :deferred_income_tax_cents
      t.integer :stock_based_compensation_cents
      t.integer :change_in_working_capital_cents
      t.integer :accounts_receivables_cents
      t.integer :accounts_payables_cents
      t.integer :other_working_capital_cents
      t.integer :other_non_cash_items_cents
      t.integer :net_cash_provided_by_operating_activities_cents
      t.integer :investments_in_property_plant_and_equipment_cents
      t.integer :acquisitions_net_cents
      t.integer :purchases_of_investments_cents
      t.integer :sales_maturities_of_investments_cents
      t.integer :other_investing_activites_cents
      t.integer :net_cash_used_for_investing_activites_cents
      t.integer :debt_repayment_cents
      t.integer :common_stock_issued_cents
      t.integer :common_stock_repurchased_cents
      t.integer :dividends_paid_cents
      t.integer :other_financing_activites_cents
      t.integer :net_cash_used_provided_by_financing_activities_cents
      t.integer :effect_of_forex_changes_on_cash_cents
      t.integer :net_change_in_cash_cents
      t.integer :cash_at_end_of_period_cents
      t.integer :cash_at_beginning_of_period_cents
      t.integer :operating_cash_flow_cents
      t.integer :capital_expenditure_cents
      t.integer :free_cash_flow_cents

      t.index %i[quote_id period calendar_year], unique: true,
                                                 name: 'index_financial_statements_on_quote_period_year'

      t.string :link
      t.string :final_link

      t.timestamps
    end
  end
end
