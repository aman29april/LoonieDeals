# frozen_string_literal: true

class CreateCashFlows < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_flows do |t|
      t.integer :fiscal_year
      t.integer :fiscal_quarter
      t.string :fiscal_period
      t.decimal :cash_from_operating_activities
      t.decimal :net_income
      t.decimal :depreciation_and_amortization
      t.decimal :deferred_income_taxes
      t.decimal :stock_based_compensation
      t.decimal :change_in_working_capital
      t.decimal :accounts_receivable
      t.decimal :inventory
      t.decimal :accounts_payable
      t.decimal :other_working_capital
      t.decimal :net_cash_from_operating_activities
      t.decimal :cash_from_investing_activities
      t.decimal :capital_expenditures
      t.decimal :acquisitions_and_disposals
      t.decimal :investment_purchases_and_sales
      t.decimal :net_cash_from_investing_activities
      t.decimal :cash_from_financing_activities
      t.decimal :net_change_in_debt
      t.decimal :issue_of_capital_stock
      t.decimal :repurchase_of_capital_stock
      t.decimal :dividend_payments
      t.decimal :other_financing_activities
      t.decimal :net_cash_from_financing_activities
      t.decimal :effect_of_exchange_rate_changes
      t.decimal :change_in_cash_and_cash_equivalents

      t.string :report_type
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
