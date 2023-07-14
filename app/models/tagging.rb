# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  tag_id       :bigint           not null
#  subject_type :string           not null
#  subject_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
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
