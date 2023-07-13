# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  description  :text
#  image        :string
#  name         :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  affiliate_id :string
#
class Store < ApplicationRecord
  has_many :deals
  has_many :coupons
  validates :name, presence: true

  has_one_attached :image
  has_rich_text :description

  validates :name, presence: true
  validate :validate_image_presence

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  def validate_image_presence
    # errors.add(:image, 'must be attached') unless image.attached?
  end
end
