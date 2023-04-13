class CreateSplitHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :split_histories do |t|
      t.references :quote, null: false, foreign_key: true
      t.date :date
      t.integer :numerator
      t.integer :denominator

      t.timestamps
    end
  end
end
