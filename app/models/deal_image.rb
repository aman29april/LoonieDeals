# frozen_string_literal: true

class DealImage
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper

  AVAILABLE_TYPES = %w[POST STORY].freeze

  attr_accessor :auto_create_link, :generated_image, :image_full_with, :store_background, :hide_discount,
                :enlarge_image_by, :hide_coupon, :type, :title, :url, :deal, :hash_tags, :coupon, :extra, :hide_deal_image, :hide_store_logo

  delegate :coupon, to: :deal
  DEFAULT_TAGS = '#LoonieDeals #CanadianDeals #canada #cheapfindscanada #canadafreestuff #dealsincanada'

  # validates :social_media_accounts, presence: true, allow_blank: false
  # validates :text, presence: true, allow_blank: false
  # validate :scheduled_at_cannot_be_in_the_past

  def initialize(params)
    @deal = Deal.find(params[:deal])
    @title = @deal.title
    @url = @deal.affiliate_url
    @hash_tags = DEFAULT_TAGS
    generate!
  end

  def deal
    @deal ||= Deal.find
  end

  def generate!
    ImageGenerationService.new(self).generate
  end

  def title_with_url
    <<~MESSAGE
      #{title}

      #{markdown_link(@url, @url)}
    MESSAGE
  end

  def photo_url
    Rails.root.join('public', 'deal_images', generated_image.split('/').last)
  end

  def title_with_tags
    return title if hash_tags.empty?

    <<~MESSAGE
      #{title}


      #{hash_tags}
    MESSAGE
  end

  def telegram_data
    [
      photo_url,
      title_with_url,
      {
        title_with_tags:,
        url: @url
      }.compact.transform_values { |v| md_monospaced(v) }
    ]
  end

  def insta_data; end
end
