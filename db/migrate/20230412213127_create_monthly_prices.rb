class CreateMonthlyPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_prices do |t|
      t.references :quote, null: false, foreign_key: true
      t.integer :year
      t.string :month
      t.string :integer
      t.integer :days
      t.integer :high_cents
      t.integer :low_cents
      t.integer :volume
      t.integer :last_day_close_cents
      t.string :currency, default: 'USD', null: false

      t.index %i[quote_id month year], unique: true
      t.timestamps
    end
  end
end
