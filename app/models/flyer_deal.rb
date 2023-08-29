# frozen_string_literal: true

class FlyerDeal
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper

  DEFAULT_TAGS = '#LoonieDeals #CanadianDeals #CanadaGroceryDeals #freshcoDeals #canada #GroceryPicksOfTheWeek #dealsincanada'

  attr_accessor :images, :image_full_with, :deal, :title, :extra, :enlarge_logo_by,
                :enlarge_image_by, :type, :theme, :hash_tags, :hide_store, :image_offset, :full_image

  def initialize(deal)
    @deal = deal
    @title = @deal.title
    @hash_tags = DEFAULT_TAGS
    @enlarge_image_by = 100
    @extra = deal.valid_range
    @full_image = true if @deal.store.dollarama?

    @images = []
    generate!
  end

  def generate!
    @images = []
    @images << FlyerImageGenerationService.new(self).banner_image
    @deal.secondary_images.each_with_index do |image, index|
      if @full_image
        name = "#{@deal.store_name}_#{index}.jpg"
        @images << ImageConversionService.resize_and_save(image, name)
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
