# frozen_string_literal: true

class CreateCompanyPeers < ActiveRecord::Migration[7.0]
  def change
    create_table :company_peers do |t|
      t.references :company, null: false, foreign_key: true
      t.references :peer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
