# frozen_string_literal: true

class Video
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include MarkdownHelper

  DEFAULT_TAGS = '#LoonieDeals #CanadianDeals #CanadaGroceryDeals #freshcoDeals #canada #GroceryPicksOfTheWeek #dealsincanada'

  attr_accessor :video, :images, :image_full_with, :deal, :title, :extra, :enlarge_logo_by,
                :enlarge_image_by, :type, :theme, :hash_tags, :hide_store, :image_offset

  def initialize(deal)
    @deal = deal
    @title = @deal.title
    @hash_tags = DEFAULT_TAGS
    @enlarge_image_by = 100
    @extra = "Valid till #{deal.expiration_date.strftime('%b %d')}"
    @images = @deal.generated_flyer_images.map(&:url)
    # generate!
  end

  def generate!
    @video = VideoService.create_video(*video_data)
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
      ouput_path,
      'Weekly deals'
    ]
  end

  # photo, caption
  def insta_data
    public_url = ImageUploadService.upload_video(ouput_path)
    [
      public_url,
      title_with_tags
    ]
  end

  def video_name
    "#{@deal.id}_deal.mp4"
  end

  def video_path
    ['/videos', video_name].join('/')
  end

  def ouput_path
    Rails.root.join('public', 'videos', video_name)
  end

  def video_data
    [
      @images,
      nil,
      ouput_path,
      1.2
    ]
  end
end
