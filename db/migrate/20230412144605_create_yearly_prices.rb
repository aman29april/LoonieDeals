# frozen_string_literal: true

class CreateYearlyPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :yearly_prices do |t|
      t.references :quote, null: false, foreign_key: true
      t.integer :year
      t.integer :avg_cents
      t.integer :high_cents
      t.integer :low_cents
      t.float :pe
      t.string :currency, default: 'USD', null: false

      t.index %i[quote_id year], unique: true
      t.timestamps
    end
  end
end
