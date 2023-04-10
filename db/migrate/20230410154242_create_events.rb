# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.date :date
      t.text :description
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
