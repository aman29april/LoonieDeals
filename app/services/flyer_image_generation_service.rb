# frozen_string_literal: true

require 'rmagick'
include Magick
require 'open-uri'

class FlyerImageGenerationService
  include ImageGeneration::Annotations

  BASE_IMAGES = {
    'flyer_post': 'blank',
    'story': 'story'
  }.with_indifferent_access.freeze

  def initialize(flyer_image, index = 100)
    @flyer_image = flyer_image
    @deal = flyer_image.deal
    @index = index
    @image = @deal.secondary_images[index]
    @type = 'flyer_post'
    theme = 'light'
    base_image_path = determine_base_image(@type, theme)
    @base_image = Image.read(base_image_path).first
    @options = ImageGeneration::Options.flyer(@type, theme)
  end

  DEFAULT_BASE_IMAGE = 'blank'

  def generate
    overlay_main_image
    overlay_store_logo(y: 900, x: 20, opacity: 0.9, width: 200, height: 150)

    write_short_slug
    save_image
  end

  def collage
    images = @deal.secondary_images.map(&:url)

    banner = "public#{banner_image}"
    images.insert(4, banner)
    images *= 2
    ImageGeneration::Collage.in_grid(images, @flyer_image.image_size)
  end

  def banner_or_collage
    @flyer_image.collage ? collage : banner_image
  end

  def banner_image
    override_base_image
    overlay_store_logo
    write_title

    write_extra

    # write_swipe_text

    write_short_slug
    save_image
  end

  def override_base_image
    return if @deal.store.dollarama?

    name = 'flyer_banner_light.png'
    # name = 'dollarama.png' if @deal.store.dollarama?
    base_image_path = Rails.root.join('app', 'assets', 'images', 'templates', name)
    @base_image = Image.read(base_image_path).first
  end

  def overlay_store_logo(opts = {})
    store = @deal.store
    if store&.image&.attached?
      options = {}
      options.merge! @options[:store_logo]
      options.merge! opts
      url = ApplicationController.helpers.cloudinary_url(store.image.attachment.key)
      overlay = Magick::Image.read(url).first
      @base_image = overlay_image_in_center(@base_image, overlay, options)
    else
      write_text_in_center(@base_image, store.name, @options[:store_name])
    end
  end

  def write_title
    return if @flyer_image.title.blank?

    title = @flyer_image.title
    options = {}
    options.merge!(@options[:title])
    write_text_in_center(@base_image, title, options)
  end

  def write_extra
    return if @flyer_image.extra.blank?

    msg = @flyer_image.extra
    options = {}
    options.merge!(@options[:extra])
    write_text_in_center(@base_image, msg, options)
  end

  def write_swipe_text
    msg = 'Swipe right →'
    options = {}
    options.merge!(@options[:swipe])
    write_text_in_center(@base_image, msg, options)
  end

  def save_image
    name = [@deal.id, @type, 'flyer', @index].compact.join('_')
    name = "#{name}.jpg"
    composite_image_path = Rails.root.join('public', 'deal_images', name)
    @base_image.write(composite_image_path)
    "/deal_images/#{name}"
  end

  def write_short_slug
    return if @deal.short_slug.blank?

    msg = "##{@deal.short_slug}"
    write_text_in_center(@base_image, msg, @options[:short_slug])
  end

  def overlay_main_image
    return unless @image.present?

    options = {}
    # options.merge! @options[:deal_image]
    # options.merge!(image_full_with: true) if @deal_image.image_full_with == '1'
    options.merge!(enlarge_image_by: @flyer_image.enlarge_image_by.to_i)
    # options.merge!(y_offset: @deal_image.image_offset.to_i) if @deal_image.image_offset.present?
    overlay = Magick::Image.read(@image.url).first

    @base_image = overlay_image_in_center(@base_image, overlay, options)
  end

  def determine_base_image(social_media_type, theme)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    extension = 'png'
    themed_img = [img_name, theme].reject(&:blank?).join('_')
    final_img = [themed_img, extension].join('.').downcase
    Rails.root.join('app', 'assets', 'images', 'templates', final_img)
  end
end
