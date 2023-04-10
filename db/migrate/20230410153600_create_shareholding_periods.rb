# frozen_string_literal: true

class CreateShareholdingPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :shareholding_periods do |t|
      t.references :quote, null: false, foreign_key: true
      t.string :period_type
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
