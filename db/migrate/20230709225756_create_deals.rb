class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.references :store, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :price
      t.decimal :discount

      t.string :url
      t.boolean :pinned
      
      
      t.date :expiration_date
      t.integer :view_count, default: 0
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0

      t.timestamps
    end
  end
end
