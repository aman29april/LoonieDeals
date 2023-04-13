# frozen_string_literal: true

class CreateIncomeStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :income_statements do |t|
      t.string :currency, default: 'USD', null: false
      t.date :date
      t.string :cik
      t.date :filling_date, default: 0, null: false
      t.date :accepted_date, default: 0, null: false
      t.integer :calendar_year, null: false
      t.string :period

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

      t.string :link
      t.string :final_link
      t.references :quote, null: false, foreign_key: true
      t.index %i[quote_id period calendar_year], unique: true
      t.timestamps
    end
  end
end
