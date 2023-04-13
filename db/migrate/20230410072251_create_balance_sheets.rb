# frozen_string_literal: true

class CreateBalanceSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :balance_sheets do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :date
      t.datetime :filling_date
      t.datetime :accepted_date
      t.integer :calendar_year
      t.string :period
      t.string :cik
      t.string :currency, default: 'USD', null: false

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
      t.string :link
      t.string :final_link

      t.index %i[quote_id period calendar_year], unique: true

      t.timestamps
    end
  end
end
