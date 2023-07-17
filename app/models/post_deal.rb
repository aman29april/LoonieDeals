# frozen_string_literal: true

class PostDeal
  include ActiveModel::Model

  attr_accessor :deal_id, :social_media_accounts, :text, :scheduled_at

  validates :social_media_accounts, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false
  validate :scheduled_at_cannot_be_in_the_past

  def save
    return false if invalid?

    social_media_accounts.each do |account|
      case account
      when 'facebook'
        post_to_facebook(@deal, text)
      when 'instagram'
        post_to_instagram(@deal, text)
      when 'twitter'
        post_to_twitter(@deal, text)
      end
    end

    true
  end

  private

  def scheduled_at_cannot_be_in_the_past
    return if scheduled_at.blank?

    errors.add(:scheduled_at, "can't be in the past") if scheduled_at < Time.current
  end

  def post_to_facebook(deal, text)
    # Implement code to post the deal on Facebook using the Facebook API or SDK
    # Authenticate the user and use the appropriate API methods to create a post with the deal information
    # Handle any necessary error handling and response parsing
  end

  def post_to_instagram(deal, text)
    # Implement code to post the deal on Instagram using the Instagram API or SDK
    # Authenticate the user and use the appropriate API methods to create a post with the deal information
    # Handle any necessary error handling and response parsing
  end

  def post_to_twitter(deal, text)
    # Implement code to post the deal on Twitter using the Twitter API or SDK
    # Authenticate the user and use the appropriate API methods to create a tweet with the deal information
    # Handle any necessary error handling and response parsing
  end
end
