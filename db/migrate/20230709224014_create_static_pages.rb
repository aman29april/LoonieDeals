# frozen_string_literal: true

class CreateStaticPages < ActiveRecord::Migration[7.0]
  def change
    create_table :static_pages do |t|
      t.string 'title'
      t.string 'body'
      t.string 'picture'
      t.string 'meta_keywords'
      t.string 'meta_description'
      t.string 'slug'
      t.bigint 'user_id', null: false
      t.index ['user_id'], name: 'index_static_pages_on_user_id'

      t.timestamps
    end
  end
end
