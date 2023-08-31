# frozen_string_literal: true

class FlyerImage
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper
  include ApplicationHelper

  DEFAULT_TAGS = '#LoonieDeals #CanadianDeals #CanadaGroceryDeals #freshcoDeals #canada #GroceryPicksOfTheWeek #dealsincanada'

  attr_accessor :images, :image_full_with, :deal, :title, :extra, :enlarge_logo_by, :collage,
                :enlarge_image_by, :type, :theme, :hash_tags, :hide_store, :image_offset, :full_image

  ImageSize = Struct.new(:width, :height)

  IMAGE_SIZE = {
    post: ImageSize.new(1080, 1080),
    story: ImageSize.new(1080, 1920)
  }.freeze

  def initialize(deal)
    @deal = deal
    @title = @deal.title
    @hash_tags = "#{DEFAULT_TAGS} #{to_human_hashtag(@deal.store_name)}"
    @enlarge_image_by = 100
    @type = :post if @type.blank?
    @extra = deal.valid_range
    if @deal.store.dollarama?
      @full_image = true
      @collage = true
    end
    @collage = true

    @images = []
    generate!
  end

  def image_size
    IMAGE_SIZE[@type.to_sym]
  end

  def generate!
    @images = []
    @images << FlyerImageGenerationService.new(self).banner_or_collage
    @deal.secondary_images.each_with_index do |image, index|
      if @full_image
        name = "#{@deal.store_name}_#{index}.jpg"
        @images << ImageConversionService.resize_and_save(image, name, image_size)
      else
        @images << FlyerImageGenerationService.new(self, index).generate
      end
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

      #{extra}

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

  def video_data
    [
      photo_urls,
      nil,
      "public/videos/#{@deal.id}_deal.mp4",
      1.2
    ]
  end
end
