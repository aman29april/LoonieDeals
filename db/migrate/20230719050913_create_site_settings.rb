# frozen_string_literal: true

class CreateSiteSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :site_settings do |t|
      t.string :ig_id
      t.string :ig_secret_token
      t.string :facebook_access_token
      t.timestamps
    end
  end
end
