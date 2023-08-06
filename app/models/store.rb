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
  has_many :deals, dependent: :destroy
  has_many :coupons, dependent: :destroy
  validates :name, presence: true

  has_one_attached :image, dependent: :destroy
  # has_rich_text :description

  validates :name, presence: true
  validate :validate_image_presence

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  scope :by_deals, -> { order(deals_count: :desc) }
  scope :by_name, -> { order(name: :asc) }
  scope :with_attached_image, -> { includes(image_attachment: :blob) }

  def validate_image_presence
    # errors.add(:image, 'must be attached') unless image.attached?
  end
end
