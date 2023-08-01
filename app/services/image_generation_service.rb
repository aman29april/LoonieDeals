# frozen_string_literal: true

require 'rmagick'
include Magick
require 'open-uri'

class ImageGenerationService
  extend ApplicationHelper
  include Rails.application.routes.url_helpers

  BASE_IMAGES = {
    'facebook' => 'facebook_base_image.jpg',
    'twitter' => 'twitter_base_image.jpg'
  }.freeze


  def initialize(deal)
    @deal = deal
  end

  COLORS = [
    
  ]

  FONTS =  {
    title: { size: 60, color: '#063E66', y: 180, break_line: true },
    price: { size: 55, color:  '#063E66', y: 1120 },
    coupon: { size: 40, color:  'white', y: 1140, x: 40, fill: 'black', stroke: ''},
    retail_price: { size: 30, color: '#063E66', y: 1120, x: 190, strike: true, gravity: nil },
    discount: { size: 30, color: '#FFFFFF', y: 1150, x: 950, fill: 'red' },
    store_name: { size: 50, color: '#063E66', y: 1630 }
  }

  IMAGES = {
    deal: { y: 400 },
    store_logo: { y: 1600, height: 170 }
  }

  DEFAULT_BASE_IMAGE = 'story.png'
  FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'OpenSans-Regular.ttf').to_s

  def to_money(val)
    ApplicationController.helpers.to_money(val)
  end

  def generate( social_media_type = 'story')
    ActiveStorage::Current.url_options = Rails.application.config.action_controller.default_url_options

    base_image_path = determine_base_image(social_media_type)
    deal_image_path = Rails.application.routes.url_helpers.url_for(@deal.image)

    base_image = Image.read(base_image_path).first

    title = @deal.title || 'DUMMY text here here here here here here here here here'
    write_text_in_center(base_image, title, FONTS[:title])

    if @deal.price?
      write_text_in_center(base_image, to_money(@deal.price), FONTS[:price])
    end

    if @deal.retail_price?
      text = "#{to_money(@deal.retail_price)}" 
      write_text_in_center(base_image, text, FONTS[:retail_price])
    end

    if @deal.discount? && @deal.hide_discount != '1'
      text = @deal.discount_percentage + '\n' + 'OFF'
      base_image = add_text_inside_circle(base_image, text, FONTS[:discount])
    end

    if @deal.coupon? && !@deal.hide_coupon
      text = "Coupon: #{@deal.coupon}"
      base_image = add_text_inside_rounded_rect(base_image, text, FONTS[:coupon])
    end

    if deal_image_path.present?
      options = {}
      options.merge!(image_full_with: true) if @deal.image_full_with == '1'
      options.merge!(enlarge_image_by: @deal.enlarge_image_by.to_i) if @deal.enlarge_image_by.to_i > 0
      overlay = Magick::Image.read(@deal.image.url).first
      base_image = overlay_image_in_center(base_image, overlay, options)
    end

    # SET store logo
    store = @deal.store || Store.first
    if store && store.image.attached?
      options = {}
      options = IMAGES[:store_logo]
      options.merge!(with_background: true) if @deal.store_background == '1'
      overlay = Magick::Image.read(store.image.url).first
      base_image = overlay_image_in_center(base_image, overlay, options)
    else
      write_text_in_center(base_image, store.name, FONTS[:store_name])
    end

    # Composite the deal image onto the base image
    # base_image.composite!(deal_image, 50, 50, Magick::OverCompositeOp)

    # Add fire reaction or smiley emoji
    # emoji_path = Rails.root.join('app', 'assets', 'images', 'fire_emoji.png') # Or smiley emoji path
    # emoji = Magick::Image.read(emoji_path).first
    # base_image.composite!(emoji, Magick::NorthWestGravity, 200, 370, Magick::OverCompositeOp)


    # Add watermark
    # watermark_path = Rails.root.join('app', 'assets', 'images', 'watermark.png')
    # watermark = Magick::Image.read(watermark_path).first
    # base_image.composite!(watermark, Magick::SouthEastGravity, 20, 20, Magick::OverCompositeOp)

    # Add text overlays for the deal title, price, retail price, and store
    # base_image.combine_options do |c|
    #   c.font FONT_PATH
    #   c.fill 'black'
    #   c.gravity 'northwest'
    #   c.pointsize 30
    #   c.draw "text 100,100 '#{deal.title}'"
    #   c.pointsize 24
    #   # c.draw "text 100,150 'Price: $#{deal.price}'"
    #   # c.draw "text 100,200 'Retail Price: $#{deal.retail_price}'"
    #   # c.draw "text 100,250 'Store: #{deal.store.name}'"
    # end

    # Save the composite image to a file or upload it to storage
    composite_image_path = Rails.root.join('public', 'deal_images', "#{@deal.id}_composite.jpg")
    base_image.write(composite_image_path)

    # Return the path or URL of the composite image

    @deal.generated_image = "/deal_images/#{@deal.id}_composite.jpg"
  end

  def image_from_url(url)
    image_from_url = URI.open(url)
    img = Image.from_blob(image_from_url.read).first
  end

  def write_title(image, title)
    font_size = 70
    font_path = Rails.root.join('app', 'assets', 'fonts', 'FjallaOne-Regular.ttf').to_s
    width_of_bounding_box = image.columns - 5
    helper = RMagickTextWrapHelper.new(title, font_size, width_of_bounding_box, font_path)

    text = Draw.new
    text.pointsize = font_size
    text.gravity = NorthWestGravity
    text.fill = '#B22222'

    text_wit_line_breaks = helper.get_text_with_line_breaks
    text.annotate(image, 100, 100, 50, 140, text_wit_line_breaks)
  end

  def write_text_in_center(img, text, options = {})
    # Get the image dimensions
    width = img.columns
    height = img.rows

    font_size = options[:size]
    font_path = options[:font_path] || ''

    draw = Magick::Draw.new

    if options[:break_line]
      width_of_bounding_box = width
      text = RMagickTextWrapHelper.new(text, font_size, width_of_bounding_box, font_path).get_text_with_line_breaks
    end
    # Calculate the coordinates to place the text in the center
    metrics = draw.get_multiline_type_metrics(text)
    text_width = metrics.width
    text_height = metrics.height

    x = options[:x] || 0
    y = options[:y] || (height - metrics.height) / 2 + metrics.ascent    

    annotatation = draw.annotate(img, width, 100, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = options[:color]
      d.pointsize = font_size
      d.undercolor = 'none'
      d.decorate = LineThroughDecoration if options[:strike]
    end
  end


  def add_text_inside_circle(img, text, options)
    circle_color = options[:circle_color] || '#9B0A24'
    text_color = options[:color] || 'white'

    # Calculate the coordinates to place the text in the center
    text_draw = Magick::Draw.new
    text_draw.pointsize = 24 # Change this to adjust the font size
    text_draw.font_weight = Magick::BoldWeight
    
    metrics = text_draw.get_multiline_type_metrics(text)
    text_width = metrics.width 
    text_height = metrics.height

    x = options[:x] || 0
    y = options[:y] || (height - metrics.height) / 2 + metrics.ascent  

    # Calculate the size of the circle based on the smaller dimension of the image
    circle_size = [text_width, text_height, 50].min

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
    circle.ellipse(x, y, circle_size-5, circle_size-5, 0, 360)
    circle.draw(img)

    text_draw.annotate(img, circle_size /10.0, circle_size/10.0, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = text_color
      d.undercolor = 'none'
    end

    img
  end

  def add_text_inside_rounded_rect(img, text, options)
    width = img.columns
    height = img.rows
    text_color = 'black'
    text_draw = Magick::Draw.new
    text_draw.pointsize = options[:size] || 24
    text_draw.font_weight = Magick::BoldWeight
    
    metrics = text_draw.get_multiline_type_metrics(text)
    text_width = metrics.width 
    text_height = metrics.height

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
    rectangle.roundrectangle(rectangle_x, rectangle_y, rectangle_x + rectangle_width, rectangle_y + rectangle_height, corner_size, corner_size)
    rectangle.draw(img)

    text_draw.annotate(img, rectangle_width, rectangle_height, x, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = options[:color] || 'red'
      d.undercolor = 'none'
    end

    img
  end

  def determine_base_image(social_media_type)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    Rails.root.join('app', 'assets', 'images', 'templates', img_name)
  end

  def overlay_image_in_center(main_img, overlay_img, options = {})
    main_width = main_img.columns
    main_height = main_img.rows
    enlarge_factor = options[:enlarge_image_by] || 0

    overlay_width = (options[:image_full_with] ? main_width  : 500) + enlarge_factor
    overlay_height = (options[:height] || 600 ) + enlarge_factor

    overlay_img.resize_to_fit!(overlay_width, overlay_height)

    overlay_width = overlay_img.columns
    overlay_height = overlay_img.rows

    # Calculate the coordinates to place the overlay image in the center
    x = (main_width - overlay_width) / 2.0
    # y = (main_height - overlay_height) / 2
    y = options[:y] || 400

    overlay_img = add_background_color(overlay_img) if options[:with_background]

    main_img.composite!(overlay_img, x, y, Magick::OverCompositeOp)
  end

  def add_background_color(image, background_color='white')
    width = image.columns
    height = image.rows
    background_image = Magick::Image.new(width, height) do |img|
      img.background_color = background_color
     end
    background_image.composite(image, 0, 0, Magick::OverCompositeOp)
  end

end

class RMagickTextWrapHelper
  def initialize(text_to_print, font_size, width_of_bounding_box, path_to_font_file = nil)
    @text_to_print = text_to_print
    @font_size = font_size
    @path_to_font_file = path_to_font_file
    @width_of_bounding_box = width_of_bounding_box
  end

  def get_text_with_line_breaks
    fit_text(@text_to_print, @width_of_bounding_box)
  end

  def text_fit?(text, width)
    tmp_image = Magick::Image.new(width, 500)

    drawing = Magick::Draw.new

    drawing.gravity = Magick::NorthGravity
    drawing.pointsize = @font_size
    drawing.fill = '#ffffff'

    drawing.font_family = @path_to_font_file if @path_to_font_file

    drawing.font_weight = Magick::BoldWeight
    drawing.annotate(tmp_image, 0, 0, 0, 0, text)

    metrics = drawing.get_multiline_type_metrics(tmp_image, text)
    (metrics.width < width)
  end

  def fit_text(text, width)
    separator = ' '
    line = ''

    if !text_fit?(text, width) && text.include?(separator)
      i = 0
      text.split(separator).each do |word|
        tmp_line = if i.zero?
                     line + word
                   else
                     line + separator + word
                   end

        if text_fit?(tmp_line, width)
          line += separator unless i.zero?
        else
          line += '\n' unless i.zero?
        end
        line += word
        i += 1
      end
      text = line
    end
    text
  end
end
