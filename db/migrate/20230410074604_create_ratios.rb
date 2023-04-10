# frozen_string_literal: true

class CreateRatios < ActiveRecord::Migration[7.0]
  def change
    create_table :ratios do |t|
      t.string :name
      t.decimal :value
      t.integer :year
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
