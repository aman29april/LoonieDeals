# frozen_string_literal: true

class CreateSectors < ActiveRecord::Migration[7.0]
  def change
    create_table :sectors do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
