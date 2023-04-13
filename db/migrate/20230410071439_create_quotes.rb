# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :name
      t.string :ticker
      t.string :sector
      t.integer :market_cap
      t.integer :full_time_employees
      t.integer :ipo_year
      t.date :ipo_date
      t.text :description
      t.string :website
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :ceo
      t.date :founded

      t.decimal :dcf_diff
      t.decimal :dcf
      t.string :image

      t.string :country
      t.string :fund_family
      t.decimal :expense_ratio, default: 0
      t.decimal :beta
      t.decimal :dividend_yield, default: 0
      t.decimal :pe_ratio
      t.decimal :forward_pe_ratio
      t.decimal :earnings_per_share
      t.decimal :price_to_book_ratio
      t.string :currency, default: 'USD', null: false
      t.integer :open_price_cents, default: 0, null: false
      t.integer :close_price_cents, default: 0, null: false
      t.integer :price_cents, default: 0, null: false
      t.integer :l52w_high_cents, default: 0, null: false
      t.integer :l52w_low_cents, default: 0, null: false
      t.decimal :roce

      t.integer :volume

      t.float :last_div
      t.float :net_assets
      t.boolean :is_etf
      t.boolean :is_fund
      t.string :cik
      t.string :isin
      t.string :cusip

      t.references :exchange, null: false, foreign_key: true
      t.references :sector, foreign_key: true
      t.references :industry, foreign_key: true
      t.string :type
      t.string :exchange_url
      t.date :upcoming_earnings,
             t.timestamps
    end
  end
end
