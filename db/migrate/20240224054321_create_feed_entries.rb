class CreateFeedEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :feed_entries do |t|
      t.string :title
      t.string :source_url
      t.string :deal_url
      t.datetime :published_at
      t.string :description
      t.string :tags
      t.integer :category_id
      t.integer :store_id
      t.string :image

      t.timestamps
    end
  end
end
