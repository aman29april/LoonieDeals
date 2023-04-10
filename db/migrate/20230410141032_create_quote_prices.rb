# frozen_string_literal: true

class CreateQuotePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :quote_prices do |t|
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.float :price
      t.integer :volume
      t.date :date
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
