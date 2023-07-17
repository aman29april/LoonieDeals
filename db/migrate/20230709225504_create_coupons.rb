# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.references :store, null: false, foreign_key: true
      t.string :code
      t.decimal :discount
      t.date :expiration_date

      t.timestamps
    end
  end
end
