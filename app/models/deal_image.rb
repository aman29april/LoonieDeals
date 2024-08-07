# frozen_string_literal: true

class DealImage
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper

  AVAILABLE_TYPES = %w[post story].freeze
  THEMES = %w[light dark simple amazon].freeze

  attr_accessor :auto_create_link, :generated_image, :image_full_with, :store_background, :hide_discount,
                :enlarge_image_by, :hide_coupon, :type, :title, :url, :deal, :hash_tags, :coupon, :extra, :hide_deal_image, :theme, :enlarge_logo_by, :custom_image, :subheading, :sub_as_tag, :image_offset, :title_auto_break, :hide_store, :only_deal_image

  # delegate :coupon, to: :deal
  DEFAULT_TAGS = '#LoonieDeals #CanadianDeals #canada #cheapfindscanada #canadafreestuff #dealsincanada'

  def initialize(deal_id)
    @deal = Deal.friendly.find(deal_id)
    @title = @deal.title
    @url = @deal.affiliate_url
    @extra = @deal.body_text
    @coupon = @deal.coupon
    @hash_tags = DEFAULT_TAGS
    @title_auto_break = '1'
    @theme = 'amazon' if @deal.store.top_store?
    generate!
  end

  # def deal
  #   @deal ||= Deal.friendly.find
  # end

  def generate!
    ImageGenerationService.new(self).generate
  end

  def title_with_tags
    <<~MESSAGE
      #{title}

      #{hash_tags}
    MESSAGE
  end

  def md_title_with_url
    <<~MESSAGE
      #{title}

      #{markdown_link(@url, @url)}
    MESSAGE
  end

  def photo_url
    Rails.root.join('public', 'deal_images', @generated_image.split('/').last)
  end

  def title_with_tags
    return title if hash_tags.empty?

    <<~MESSAGE
      #{title}


      #{hash_tags}
    MESSAGE
  end

  # photo, text
  def telegram_data
    [
      photo_url,
      md_title_with_url,
      {
        title_with_tags:,
        url: @url
      }.compact.transform_values { |v| md_monospaced(v) }
    ]
  end

  # photo, caption
  def insta_data
    public_photo_url = ImageUploadService.upload_image(photo_url)
    [
      public_photo_url,
      title_with_tags
    ]
  end

  # def upload_to_cloud
  #   response = Cloudinary::Uploader.upload(photo_url,
  #                                          folder: 'looniedeals/tmp/',
  #                                          public_id: 'instagram_upload',
  #                                          overwrite: true,
  #                                          resource_type: 'image',
  #                                          use_filename: true,
  #                                          unique_filename: false)

  #   # response['url']
  #   response['secure_url']
  # end
end
