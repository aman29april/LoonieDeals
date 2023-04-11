# frozen_string_literal: true

class CreateQuotePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :quote_prices do |t|
      t.decimal :open_price
      t.decimal :high_price
      t.decimal :low_price
      t.decimal :close_price
      t.float :price
      t.float :adj_close_price
      t.integer :volume
      t.date :date
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
