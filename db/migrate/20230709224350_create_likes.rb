# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.string 'likeable_type'
      t.integer 'likeable_id'
      t.integer 'user_id'

      t.index %w[likeable_type likeable_id], name: 'index_likes_on_likeable_type_and_likeable_id'
      t.index ['user_id'], name: 'index_likes_on_user_id'

      t.timestamps
    end
  end
end
