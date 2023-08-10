# frozen_string_literal: true

class CreateDealsCategoriesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :deals, :categories do |t|
      t.index %i[deal_id category_id]
      t.index %i[category_id deal_id]
    end

    change_column_null :deals, :category_id, true
  end
end
