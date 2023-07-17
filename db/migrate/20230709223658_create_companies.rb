# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string 'name'
      t.string 'logo'
      t.string 'hq'
      t.string 'address'
      t.string 'linkedin'
      t.string 'indeed'
      t.string 'url'

      t.timestamps
    end
  end
end
