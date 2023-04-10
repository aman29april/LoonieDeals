# frozen_string_literal: true

class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.references :popular_investors, null: false, foreign_key: true
      t.integer :number_of_shares
      t.integer :year
      t.integer :quarter

      t.timestamps
    end
  end
end
