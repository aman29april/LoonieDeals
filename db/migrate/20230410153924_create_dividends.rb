# frozen_string_literal: true

class CreateDividends < ActiveRecord::Migration[7.0]
  def change
    create_table :dividends do |t|
      t.references :quote, null: false, foreign_key: true

      t.date :date
      t.date :declaration_date
      t.date :record_date
      t.date :payment_date

      t.integer :amount_cents
      t.string :currency, default: 'USD', null: false

      t.timestamps
    end
  end
end
