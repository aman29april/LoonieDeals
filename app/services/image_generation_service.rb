# frozen_string_literal: true

require 'rmagick'
include Magick
require 'open-uri'

class ImageGenerationService
  include ImageGeneration::Annotations

  BASE_IMAGES = {
    'post': 'post',
    'story': 'story'
  }.with_indifferent_access.freeze

  MAX_TITLE_LENGTH = 120
  MAX_SUBHEADING_LENGTH = 50
  MAX_EXTRA_LENGTH = 50

  def initialize(deal_image)
    @deal_image = deal_image
    @deal = @deal_image.deal

    type = @deal_image.type.blank? ? 'story' : @deal_image.type
    theme = @deal_image.theme.blank? ? 'light' : @deal_image.theme
    base_image_path = determine_base_image(type, theme)
    @base_image = Image.read(base_image_path).first
    @options = ImageGeneration::Options.for(type, theme)
  end

  DEFAULT_BASE_IMAGE = 'story'
  FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'OpenSans-Regular.ttf').to_s

  def to_money(val)
    ApplicationController.helpers.to_money(val)
  end

  def generate
    if @deal_image.only_deal_image == '1'
      @base_image = Magick::Image.read(@deal.image.url).first
      save_image
      return
    end
    overlay_deal_image
    overlay_store_logo
    write_title
    write_price
    write_extra
    write_subheading
    write_retail_price
    write_discount
    write_coupon
    write_short_slug

    save_image
  end

  def save_image
    name = [@deal.id, @deal_image.type].compact.join('_')
    name = "#{name}.jpg"
    composite_image_path = Rails.root.join('public', 'deal_images', name)
    @base_image.write(composite_image_path)
    @deal_image.generated_image = "/deal_images/#{name}"
  end

  def truncate_params
    {omission: '', separator: ' '}
  end
  def write_title
    return if @deal_image.title.blank?

    title = @deal_image.title.truncate(MAX_TITLE_LENGTH, truncate_params)
    options = {}
    options.merge!(@options[:title])
    options[:break_line] = (@deal_image.title_auto_break == '1')
    write_text_in_center(@base_image, title, options)
  end

  def write_extra
    return if @deal_image.extra.blank?

    msg = @deal_image.extra.truncate(MAX_EXTRA_LENGTH, truncate_params)
    write_text_in_center(@base_image, msg, @options[:extra])
  end

  def write_subheading
    return if @deal_image.subheading.blank?

    options = {}
    options.merge!(@options[:subheading])
    msg = @deal_image.subheading.truncate(MAX_SUBHEADING_LENGTH, truncate_params)
    if @deal_image.sub_as_tag == '1'
      options[:color] = 'white'
      options[:size] = 32
      options[:corner_radius] = 10
      add_text_inside_rounded_rect(msg, options)
    else
      write_text_in_center(@base_image, msg, options)
    end
  end

  def write_short_slug
    return if @deal.short_slug.blank?

    msg = "##{@deal.short_slug}"
    write_text_in_center(@base_image, msg, @options[:short_slug])
  end

  def write_price
    write_text_in_center(@base_image, to_money(@deal.price), @options[:price]) if @deal.price?
  end

  def write_retail_price
    return unless @deal.retail_price?

    text = to_money(@deal.retail_price).to_s
    write_text_in_center(@base_image, text, @options[:retail_price])
  end

  def write_discount
    return unless @deal.discount? && @deal_image.hide_discount != '1'

    text = "#{@deal.discount_percentage}\\nOFF"
    @base_image = add_text_inside_circle(@base_image, text, @options[:discount])
  end

  def write_coupon
    return unless @deal_image.coupon.present? && @deal_image.hide_coupon != '1'

    text = "Code: #{@deal_image.coupon}"
    @base_image = add_text_inside_rounded_rect(text, @options[:coupon])
  end

  def overlay_deal_image
    deal_image_path = @deal.image
    return unless deal_image_path.present?

    options = {}
    options.merge! @options[:deal_image]
    options.merge!(image_full_with: true) if @deal_image.image_full_with == '1'
    options.merge!(enlarge_image_by: @deal_image.enlarge_image_by.to_i)
    options.merge!(y_offset: @deal_image.image_offset.to_i) if @deal_image.image_offset.present?
    overlay = Magick::Image.read(@deal.image.url).first

    @base_image = overlay_image_in_center(@base_image, overlay, options)
  end

  def overlay_store_logo
    return if @deal_image.hide_store == '1'

    store = @deal.store
    if store&.image&.attached?
      options = {}
      options.merge! @options[:store_logo]
      options.merge!(with_background: true) if @deal_image.store_background == '1'
      options.merge!(enlarge_image_by: @deal_image.enlarge_logo_by.to_i)
      url = ApplicationController.helpers.cloudinary_url(store.image.attachment.key)

      overlay = if store.image.blob.content_type.include?('svg')
                  svg_to_png(url)
                else
                  Magick::Image.read(url).first
                end

      @base_image = overlay_image_in_center(@base_image, overlay, options)
    else
      write_text_in_center(@base_image, store.name, @options[:store_name])
    end
  end

  def add_text_inside_rounded_rect(text, options)
    add_text_inside_rounded_rectangle(@base_image, text, options)
  end

  def determine_base_image(social_media_type, theme)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    extension = 'png'
    themed_img = [img_name, theme].reject(&:blank?).join('_')
    final_img = [themed_img, extension].join('.').downcase
    Rails.root.join('app', 'assets', 'images', 'templates', final_img)
  end

  def convert_svg_to_png(str)
    img = Magick::Image.from_blob(str) do |image|
      image.format = 'SVG'
      image.background_color = 'transparent'
    end.first

    img.to_blob do |image|
      image.format = 'PNG'
    end
  end

  def to_png(image)
    png = Magick::Image.from_blob(image) do |img|
      img.format = 'PNG'
      img.background_color = 'transparent'
    end
    Magick::Image.from_blob(png).first
  end
end
