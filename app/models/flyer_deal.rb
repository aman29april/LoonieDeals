# frozen_string_literal: true

class FlyerDeal
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper

  attr_accessor :images, :image_full_with, :deal, :title,
                :enlarge_image_by, :type, :theme, :hash_tags, :hide_store, :image_offset

  def initialize(deal)
    @deal = deal
    @images = []
    generate!
  end

  def generate!
    @images = []
    @images << FlyerImageGenerationService.new(@deal).banner_image
    @deal.secondary_images.each_with_index do |_image, index|
      @images << FlyerImageGenerationService.new(@deal, index).generate
    end
    @images
  end

  def photo_urls
    @images.map do |image|
      Rails.root.join('public', 'deal_images', image.split('/').last)
    end
  end

  def title_with_tags
    <<~MESSAGE
      #{title}

      #{hash_tags}
    MESSAGE
  end

  def telegram_data
    [
      photo_urls,
      'Weekly deals'
    ]
  end

  # photo, caption
  def insta_data
    public_photo_urls = ImageUploadService.upload_images(photo_urls)
    [
      public_photo_urls,
      title_with_tags
    ]
  end
end
