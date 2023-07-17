# frozen_string_literal: true

class CreateTagRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_relationships do |t|
      t.integer 'tag_id', null: false
      t.integer 'related_tag_id', null: false
      t.integer 'relevance', default: 0, null: false

      t.index ['related_tag_id'], name: 'index_tag_relationships_on_related_tag_id'
      t.index %w[tag_id related_tag_id], name: 'index_tag_relationships_on_tag_id_and_related_tag_id', unique: true
      t.index ['tag_id'], name: 'index_tag_relationships_on_tag_id'

      t.timestamps
    end
  end
end
