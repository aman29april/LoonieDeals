# frozen_string_literal: true

class CreatePopularInvestors < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_investors do |t|
      t.string :name
      t.integer :age
      t.text :bio

      t.timestamps
    end
  end
end
