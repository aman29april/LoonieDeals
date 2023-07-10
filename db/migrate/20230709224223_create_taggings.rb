class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.bigint 'tag_id', null: false
      t.string 'subject_type', null: false
      t.bigint 'subject_id', null: false

      t.index %w[subject_type subject_id], name: 'index_taggings_on_subject'
      t.index ['tag_id'], name: 'index_taggings_on_tag_id'

      t.timestamps
    end
  end
end
