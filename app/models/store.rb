# frozen_string_literal: true

# == Schema Information
#
# Table name: stores
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  website          :string
#  affiliate_id     :string
#  featured         :boolean          default(FALSE)
#  slug             :string
#  meta_keywords    :string
#  meta_description :string
#  deals_count      :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Store < ApplicationRecord
  has_many :deals
  has_many :coupons
  validates :name, presence: true

  has_one_attached :image
  # has_rich_text :description

  validates :name, presence: true
  validate :validate_image_presence

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  scope :by_deals, -> { order(deals_count: :desc) }
  scope :by_name, -> { order(name: :asc) }

  def validate_image_presence
    # errors.add(:image, 'must be attached') unless image.attached?
  end
end
