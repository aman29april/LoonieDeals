# frozen_string_literal: true

class AddTypeToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :kind, :string
    add_column :deals, :starts_at, :datetime
  end
end
