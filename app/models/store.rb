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

  validates :name, :description, :website, presence: true
  validate :validate_image_presence

  def validate_image_presence
    errors.add(:image, 'must be attached') unless image.attached?
  end
end
