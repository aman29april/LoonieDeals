# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :name
      t.string :ticker
      t.string :sector
      t.string :industry
      t.integer :market_cap
      t.integer :employees
      t.integer :ipo_year
      t.text :description
      t.string :website
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :ceo
      t.date :founded

      t.string :country
      t.string :fund_family
      t.decimal :expense_ratio, default: 0
      t.decimal :beta
      t.decimal :dividend_yield, default: 0
      t.decimal :price_to_earnings_ratio
      t.decimal :earnings_per_share
      t.decimal :price_to_book_ratio
      t.float :net_assets

      t.references :exchange, null: false, foreign_key: true
      t.references :sector, null: false, foreign_key: true
      t.string :type
      t.string :exchange_url
      t.timestamps
    end
  end
end
