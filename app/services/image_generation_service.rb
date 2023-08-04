# frozen_string_literal: true

require 'rmagick'
include Magick
require 'open-uri'

class ImageGenerationService
  BASE_IMAGES = {
    'post': 'post',
    'story': 'story'
  }.with_indifferent_access.freeze

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

  def write_title
    title = @deal_image.title || ''
    write_text_in_center(@base_image, title, @options[:title])
  end

  def write_extra
    return if @deal_image.extra.blank?

    msg = @deal_image.extra
    write_text_in_center(@base_image, msg, @options[:extra])
  end

  def write_subheading
    return if @deal_image.subheading.blank?

    msg = @deal_image.subheading
    write_text_in_center(@base_image, msg, @options[:subheading])
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
    return unless @deal.coupon? && @deal_image.hide_coupon != '1'

    text = "Coupon: #{@deal.coupon}"
    @base_image = add_text_inside_rounded_rect(@base_image, text, @options[:coupon])
  end

  def overlay_deal_image
    deal_image_path = @deal.image
    return unless deal_image_path.present?

    options = {}
    options.merge! @options[:deal_image]
    options.merge!(image_full_with: true) if @deal_image.image_full_with == '1'
    options.merge!(enlarge_image_by: @deal_image.enlarge_image_by.to_i)
    overlay = Magick::Image.read(@deal.image.url).first
    @base_image = overlay_image_in_center(@base_image, overlay, options)
  end

  def overlay_store_logo
    # SET store logo
    store = @deal.store || Store.first
    if store&.image&.attached?
      options = {}
      options.merge! @options[:store_logo]
      options.merge!(with_background: true) if @deal_image.store_background == '1'
      options.merge!(enlarge_image_by: @deal_image.enlarge_logo_by.to_i)
      url = ApplicationController.helpers.cloudinary_url(store.image.attachment.key)

      if store.image.blob.content_type.include?('svg')
        svg_string = URI(url).read
        png = convert_svg_to_png(svg_string)
        overlay = Magick::Image.from_blob(png).first
      else
        overlay = Magick::Image.read(url).first
      end

      @base_image = overlay_image_in_center(@base_image, overlay, options)
    else
      write_text_in_center(@base_image, store.name, @options[:store_name])
    end
  end

  def image_from_url(url)
    image_from_url = URI.open(url)
    Image.from_blob(image_from_url.read).first
  end

  def write_text_in_center(img, text, options = {})
    # Get the image dimensions
    width = img.columns
    height = img.rows

    font_size = options[:size]
    font = options[:font] || 'OpenSans-Regular'
    font_path = get_font_path(font)

    draw = Magick::Draw.new

    if options[:break_line]
      width_of_bounding_box = width
      text = ImageGeneration::TextHelper.new(text, font_size, width_of_bounding_box,
                                             font_path).get_text_with_line_breaks
    end
    # Calculate the coordinates to place the text in the center
    metrics = draw.get_multiline_type_metrics(text)
    metrics.width
    metrics.height

    x = options[:x] || 0
    y = options[:y] || (height - metrics.height) / 2 + metrics.ascent

    draw.annotate(img, width, 90, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = options[:color]
      d.pointsize = font_size
      d.undercolor = 'none'
      d.decorate = LineThroughDecoration if options[:strike]
      d.decorate = UnderlineDecoration if options[:underline]
      d.font_weight = BoldWeight if options[:bold]
      d.font = font_path
      d.font_style = ItalicStyle if options[:italic]
      d.interline_spacing = options[:line_spacing] if options[:line_spacing]
    end
  end

  def get_font_path(name)
    "#{Rails.root}/app/assets/fonts/#{name}.ttf"
  end

  def add_text_inside_circle(img, text, options)
    circle_color = options[:circle_color] || '#9B0A24'
    text_color = options[:color] || 'white'

    # Calculate the coordinates to place the text in the center
    text_draw = Magick::Draw.new
    text_draw.pointsize = options[:size] || 30
    text_draw.font_weight = Magick::BoldWeight

    metrics = text_draw.get_multiline_type_metrics(text)
    text_width = metrics.width
    text_height = metrics.height

    x = options[:x] || 0
    y = options[:y] || (height - metrics.height) / 2 + metrics.ascent

    # Calculate the size of the circle based on the smaller dimension of the image
    circle_size = [text_width, text_height, 50].max / 1.3

    # Draw the circle with the specified color
    circle = Magick::Draw.new
    circle.fill(circle_color)
    circle.stroke('white')
    circle.ellipse(x, y, circle_size, circle_size, 0, 360)
    circle.draw(img)

    # Draw inner stroke
    circle = Magick::Draw.new
    circle.fill('transparent')
    circle.stroke('white')
    circle.stroke_width(2)
    circle.ellipse(x, y, circle_size - 5, circle_size - 5, 0, 360)
    circle.draw(img)

    text_draw.annotate(img, circle_size / 10.0, circle_size / 10.0, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = text_color
      d.undercolor = 'none'
    end

    img
  end

  def add_text_inside_rounded_rect(img, text, options)
    width = img.columns
    img.rows
    text_draw = Magick::Draw.new
    text_draw.pointsize = options[:size] || 24
    text_draw.font_weight = Magick::BoldWeight

    metrics = text_draw.get_multiline_type_metrics(text)
    metrics.width
    metrics.height

    fill_color = options[:fill] || 'red'
    stroke_color = options[:stroke] || 'red'
    rectangle = Magick::Draw.new
    rectangle.fill(fill_color)
    rectangle.stroke(stroke_color)
    rectangle.stroke_width(2)
    buffer = 20
    rectangle_width = metrics.width + buffer # Add some padding around the text
    rectangle_height = metrics.height + buffer # Add some padding around the text

    x = options[:x] || (width - rectangle_width) / 2
    y = options[:y] || 0

    rectangle_x = x
    rectangle_y = y

    corner_size = 20
    rectangle.roundrectangle(rectangle_x, rectangle_y, rectangle_x + rectangle_width, rectangle_y + rectangle_height,
                             corner_size, corner_size)
    rectangle.draw(img)

    text_draw.annotate(img, rectangle_width, rectangle_height, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = options[:color] || 'red'
      d.undercolor = 'none'
    end

    img
  end

  def determine_base_image(social_media_type, theme)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    extension = 'png'
    themed_img = [img_name, theme].reject(&:blank?).join('_')
    final_img = [themed_img, extension].join('.').downcase
    Rails.root.join('app', 'assets', 'images', 'templates', final_img)
  end

  def overlay_image_in_center(main_img, overlay_img, options = {})
    main_width = main_img.columns
    main_img.rows
    enlarge_factor = options[:enlarge_image_by] || 0

    width = options[:width] || 600
    overlay_width = (options[:image_full_with] ? main_width : width) + enlarge_factor
    overlay_height = (options[:height] || 600) + enlarge_factor

    overlay_img.resize_to_fit!(overlay_width, overlay_height)

    overlay_width = overlay_img.columns
    overlay_img.rows

    # Calculate the coordinates to place the overlay image in the center
    x = options[:x] || (main_width - overlay_width) / 2.0
    # y = (main_height - overlay_height) / 2
    y = options[:y] || 400

    overlay_img = add_background_color(overlay_img) if options[:with_background]

    main_img.composite!(overlay_img, x, y, Magick::OverCompositeOp)
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

  def add_background_color(image, background_color = 'white')
    width = image.columns
    height = image.rows
    background_image = Magick::Image.new(width, height) do |img|
      img.background_color = background_color
    end
    background_image.composite(image, 0, 0, Magick::OverCompositeOp)
  end
end
