# frozen_string_literal: true

# == Schema Information
#
# Table name: social_media_posts
#
#  id                    :integer          not null, primary key
#  deal_id               :integer
#  social_media_accounts :text
#  text                  :text
#  scheduled_at          :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class SocialMediaPost < ApplicationRecord
  belongs_to :deal, optional: true

  has_one_attached :image
  before_create :attach_deal_image

  validates :social_media_accounts, presence: true, allow_blank: false
  validates :social_media_accounts, inclusion: { in: %w[facebook instagram twitter telegram] }
  validates :text, presence: true, allow_blank: false
  validate :scheduled_at_cannot_be_in_the_past

  private

  def scheduled_at_cannot_be_in_the_past
    return if scheduled_at.blank?

    errors.add(:scheduled_at, "can't be in the past") if scheduled_at < Time.current
  end

  def attach_deal_image
    return if deal.blank?

    image.attach(deal.image) if deal.image.attached?
  end
end
