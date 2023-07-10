class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string 'title'
      t.text 'body'
      t.integer 'likes_count', default: 0
      t.datetime 'published_at', precision: nil
      t.boolean 'featured', default: false
      t.string 'picture'

      t.bigint 'user_id'
      t.string 'slug'
      t.integer 'responses_count', default: 0, null: false
      t.text 'lead'
      t.string 'meta_keywords'
      t.string 'meta_description'
      t.string 'language'
      t.integer 'view_count', default: 0
      t.index ['slug'], name: 'index_posts_on_slug', unique: true
      t.index ['user_id'], name: 'index_posts_on_user_id'

      t.timestamps
    end
  end
end
