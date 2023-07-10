class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :affiliate_id

      t.string :image
      t.timestamps
    end
  end
end
