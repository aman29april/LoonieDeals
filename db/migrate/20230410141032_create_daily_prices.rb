# frozen_string_literal: true

class CreateDailyPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_prices do |t|
      t.integer :open_cents
      t.integer :high_cents
      t.integer :low_cents
      t.integer :close_cents
      t.integer :price_cents
      t.integer :adj_close_cents
      t.integer :volume
      t.string :currency, default: 'USD', null: false
      t.date :date
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
