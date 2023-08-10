# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  deals_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', optional: true

  has_many :deals
  has_and_belongs_to_many :stores

  validates :name, presence: true, uniqueness: true

  has_one_attached :image, dependent: :destroy

  scope :by_deals, -> { order(deals_count: :desc) }
  scope :by_name, -> { order(name: :asc) }
end
