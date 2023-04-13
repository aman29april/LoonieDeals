# frozen_string_literal: true

class CreateCashFlows < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_flows do |t|
      # t.integer :fiscal_year
      # t.integer :fiscal_quarter
      t.string :currency, default: 'USD', null: false
      t.date :date
      t.string :cik
      t.datetime :filling_date, default: 0, null: false
      t.datetime :accepted_date, default: 0, null: false
      t.integer :calendar_year, null: false
      t.string :period

      t.integer :net_income_cents
      t.integer :depreciation_and_amortization_cents
      t.integer :deferred_income_tax_cents
      t.integer :stock_based_compensation_cents
      t.integer :change_in_working_capital_cents
      t.integer :accounts_receivables_cents
      t.integer :inventory_cents
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

      t.string :link
      t.string :final_link
      t.references :quote, null: false, foreign_key: true
      t.index %i[quote_id period calendar_year], unique: true
      t.timestamps
    end
  end
end
