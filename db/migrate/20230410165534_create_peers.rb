# frozen_string_literal: true

class CreatePeers < ActiveRecord::Migration[7.0]
  def change
    create_table :peers do |t|
      t.references :company, null: false, foreign_key: true
      t.references :peer_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
