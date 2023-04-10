# frozen_string_literal: true

class CreateShareholdingPatterns < ActiveRecord::Migration[7.0]
  def change
    create_table :shareholding_patterns do |t|
      t.references :shareholding_period, null: false, foreign_key: true
      t.string :shareholder_name
      t.float :shareholding_percentage
      t.float :promoter_holding
      t.float :public_holding
      t.float :non_institutions_holding
      t.float :institutions_holding
      t.date :date

      t.timestamps
    end
  end
end
