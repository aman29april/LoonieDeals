# frozen_string_literal: true

class AddParentIdToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :slug, :string, unique: true, index: true
    add_column :categories, :position, :integer
    add_column :categories, :parent_id, :integer
    add_index :categories, :parent_id

    add_column :stores, :referral, :string
    add_column :links, :extra_info, :string

    create_join_table :categories, :stores do |t|
      t.index %i[category_id store_id]
      t.index %i[store_id category_id]
    end
  end
end
