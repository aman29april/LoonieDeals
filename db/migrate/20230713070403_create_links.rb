# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :label
      t.string :image
      t.string :url
      t.integer :number_of_clicks, default: 0
      t.boolean :pinned, default: false
      t.integer :position
      t.boolean :enabled

      t.string :short_slug
      t.references :deal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
