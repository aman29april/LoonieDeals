# frozen_string_literal: true

class CreateDividends < ActiveRecord::Migration[7.0]
  def change
    create_table :dividends do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :ex_dividend_date
      t.date :dividend_date
      t.date :record_date
      t.date :payment_date
      t.float :amount

      t.timestamps
    end
  end
end
