# frozen_string_literal: true

class CreateReferralCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :referral_codes do |t|
      t.string :referal_link
      t.string :referal_code
      t.text :referal_text
      t.integer :position
      t.boolean :enabled
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
