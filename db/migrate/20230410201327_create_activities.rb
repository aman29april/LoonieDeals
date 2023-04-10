# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.integer :action
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
