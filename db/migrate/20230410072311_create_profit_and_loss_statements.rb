# frozen_string_literal: true

class CreateProfitAndLossStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :profit_and_loss_statements do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :date
      t.integer :fiscal_year
      t.integer :fiscal_quarter
      t.integer :revenue
      t.integer :total_revenue
      t.integer :cost_of_revenue
      t.integer :gross_profit
      t.integer :research_and_development
      t.integer :selling_general_and_admin
      t.integer :operating_expenses
      t.integer :operating_income
      t.integer :interest_expense
      t.integer :other_income_expense
      t.integer :income_before_tax
      t.integer :income_tax_expense
      t.integer :minority_interest
      t.integer :net_income
      t.integer :preferred_dividends
      t.integer :earnings_available_for_common_stockholders
      t.float :basic_eps
      t.float :diluted_eps
      t.integer :basic_shares_outstanding
      t.integer :diluted_shares_outstanding
      t.float :dividends_per_share
      t.integer :gross_dividends
      t.integer :net_income_from_continuing_operations
      t.integer :net_income_from_discontinued_operations
      t.integer :net_income_from_total_operations
      t.integer :normalized_income_before_taxes
      t.integer :normalized_income_after_taxes
      t.integer :normalized_income_avail_to_common
      t.float :basic_normalized_eps
      t.float :diluted_normalized_eps

      t.timestamps
    end
  end
end
