# == Schema Information
#
# Table name: tag_relationships
#
#  id             :integer          not null, primary key
#  relevance      :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  related_tag_id :integer          not null
#  tag_id         :integer          not null
#
# Indexes
#
#  index_tag_relationships_on_related_tag_id             (related_tag_id)
#  index_tag_relationships_on_tag_id                     (tag_id)
#  index_tag_relationships_on_tag_id_and_related_tag_id  (tag_id,related_tag_id) UNIQUE
#
class TagRelationship < ActiveRecord::Base
  belongs_to :tag
  belongs_to :related_tag, class_name: 'Tag'
end
