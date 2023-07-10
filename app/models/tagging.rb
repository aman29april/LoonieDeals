# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  subject_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint           not null
#  tag_id       :bigint           not null
#
# Indexes
#
#  index_taggings_on_subject  (subject_type,subject_id)
#  index_taggings_on_tag_id   (tag_id)
#
class Tagging < ApplicationRecord
  belongs_to :subject, polymorphic: true, touch: true
  belongs_to :tag

  validates :tag, presence: true
  validates :tag_id, uniqueness: { scope: %i[subject_id subject_type] }

  delegate :name, to: :tag

  scope :by_tag, lambda { |tag_id|
    where(tag_id:).order(updated_at: :desc)
  }
end
