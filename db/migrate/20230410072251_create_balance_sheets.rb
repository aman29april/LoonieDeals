# frozen_string_literal: true

class CreateBalanceSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :balance_sheets do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :date
      t.integer :fiscal_year
      t.integer :fiscal_quarter
      t.string :fiscal_period
      t.integer :cash_and_cash_equivalents
      t.integer :short_term_investments
      t.integer :net_receivables
      t.integer :inventory
      t.integer :other_current_assets
      t.integer :total_current_assets
      t.integer :property_plant_and_equipment
      t.integer :long_term_investments
      t.integer :goodwill
      t.integer :intangible_assets
      t.integer :accumulated_amortization
      t.integer :other_assets
      t.integer :total_assets
      t.integer :accounts_payable
      t.integer :short_term_debt
      t.integer :taxes_payable
      t.integer :accrued_liabilities
      t.integer :accrued_expenses
      t.integer :other_current_liabilities
      t.integer :total_current_liabilities
      t.integer :long_term_debt
      t.integer :current_portion_of_long_term_debt
      t.integer :deferred_revenue
      t.integer :deferred_income_tax
      t.integer :other_liabilities
      t.integer :minority_interest
      t.integer :total_liabilities
      t.integer :preferred_equity
      t.integer :total_liabilities_and_stockholders_equity
      t.integer :common_stock
      t.integer :retained_earnings
      t.integer :accumulated_other_comprehensive_income
      t.integer :treasury_stock
      t.integer :total_stockholders_equity
      t.integer :total_equity
      t.integer :net_tangible_assets

      t.timestamps
    end
  end
end
