class CreateMissingStores < ActiveRecord::Migration[7.0]
  def change
    create_table :missing_stores do |t|
      t.string :name

      t.timestamps
    end
  end
end
