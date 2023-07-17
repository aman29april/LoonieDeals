# frozen_string_literal: true

class CreateSocialMediaPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media_posts do |t|
      t.references :deal, null: true, foreign_key: true
      t.text :social_media_accounts
      t.text :text

      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
