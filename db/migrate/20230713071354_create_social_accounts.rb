# frozen_string_literal: true

class CreateSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_accounts do |t|
      t.string :url
      t.integer :number_of_clicks, default: 0
      t.integer :position
      t.string :account_type

      t.timestamps
    end
  end
end
