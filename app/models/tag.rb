# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  featured       :boolean          default(FALSE)
#  lowercase_name :string
#  name           :string           not null
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :deals, through: :taggings, source: :subject, source_type: 'Deal'
  has_many :projects, through: :taggings, source: :subject, source_type: 'Project'
  validates :name, presence: true, uniqueness: { message: '%<value>s is already used' }

  has_many :tag_relationships, -> { order(relevance: :desc) }, dependent: :destroy
  has_many :related_tags, through: :tag_relationships, source: :related_tag

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  def self.first_or_create_with_name!(name)
    where(lowercase_name: name.strip.downcase).first_or_create! do |tag|
      tag.name = name.strip
    end
  end

  def meta_info
    {
      title: name,
      description: name,
      keywords: name
    }
  end
end
