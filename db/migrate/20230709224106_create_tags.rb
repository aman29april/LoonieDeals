# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string 'name', null: false

      t.boolean 'featured', default: false
      t.string 'lowercase_name'
      t.string 'slug'

      t.timestamps
    end
  end
end
