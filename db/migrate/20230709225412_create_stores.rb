class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :affiliate_id

      t.boolean :featured, default: false
      t.string :slug, unique: true
      t.string 'meta_keywords'
      t.string 'meta_description'

      t.integer :deals_count, default: 0
      t.timestamps
    end
  end
end
