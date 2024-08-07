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
  has_and_belongs_to_many :categories
  has_many :referral_codes, dependent: :destroy

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
  scope :with_referral, -> { where('referral is not null and referral != ?', '') }

  scope :top, ->(number) { by_deals.limit(number) }

  def self.search(query)
    where("LOWER(name) LIKE ?", "%#{query.downcase}%")
  end

  def validate_image_presence
    # errors.add(:image, 'must be attached') unless image.attached?
  end

  def top_store?
    amazon? || walmart?
  end

  def amazon?
    name == 'Amazon.ca'
  end

  def walmart?
    name == 'Walmart'
  end

  def dollarama?
    name == 'Dollarama'
  end

  def self.other
    Store.find_by(name: 'No Store')
  end

  def self.amazon
    Store.find_by(name: 'Amazon.ca')
  end
end
