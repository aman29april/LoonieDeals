# frozen_string_literal: true

class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :title, null: false
      t.text :body
      t.decimal :price
      t.decimal :retail_price
      t.decimal :discount

      t.string :url
      t.string :coupon
      t.boolean :pinned, default: false

      t.datetime :published_at, precision: nil
      t.boolean :featured, default: false

      t.string :slug, unique: true
      t.string :short_slug, unique: true
      t.string :meta_keywords
      t.string :meta_description

      t.datetime :expiration_date
      t.integer :view_count, default: 0
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0

      t.references :store, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
