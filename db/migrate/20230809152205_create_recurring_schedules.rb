# frozen_string_literal: true

class CreateRecurringSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :recurring_schedules do |t|
      t.references :deal, null: false, foreign_key: true
      t.string :recurrence_type
      t.string :day_of_week
      t.integer :day_of_month

      t.datetime :starts_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
