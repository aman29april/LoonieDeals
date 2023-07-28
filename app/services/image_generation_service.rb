# frozen_string_literal: true

require 'rmagick'
include Magick
require 'open-uri'

class ImageGenerationService
  include Rails.application.routes.url_helpers

  BASE_IMAGES = {
    'facebook' => 'facebook_base_image.jpg',
    'twitter' => 'twitter_base_image.jpg'
  }.freeze

  FONTS =  {
    title: { size: 60, color: '#063E66', y: 180, break_line: true },
    price: { size: 55, color:  '#063E66', y: 1120 },
    orignal_price: { size: 30, color: '#063E66' },
    store_name: { size: 50, color: '#063E66', y: 1630 }
  }

  IMAGES = {
    deal: { y: 400 },
    store_logo: { y: 1600, height: 130 }
  }

  DEFAULT_BASE_IMAGE = 'story.png'
  FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'OpenSans-Regular.ttf').to_s

  def self.generate_deal_image(deal, social_media_type = 'story')
    ActiveStorage::Current.url_options = Rails.application.config.action_controller.default_url_options

    base_image_path = determine_base_image(social_media_type)
    deal_image_path = Rails.application.routes.url_helpers.url_for(deal.image)

    # base_image = MiniMagick::Image.open(base_image_path)

    base_image = Image.read(base_image_path).first

    title = 'DUMMY text here here here here here here here here here'
    write_text_in_center(base_image, title, FONTS[:title])
    write_text_in_center(base_image, '$20.00', FONTS[:price])

    if deal_image_path.present?
      overlay = Magick::Image.read(deal.image.url).first
      base_image = overlay_image_in_center(base_image, overlay)
    end

    if Store.first.image.present?
      overlay = Magick::Image.read(Store.first.image.url).first
      base_image = overlay_image_in_center(base_image, overlay, IMAGES[:store_logo])
    else
      write_text_in_center(base_image, 'Amazon', FONTS[:store_name])
    end

    # Composite the deal image onto the base image
    # base_image.composite!(deal_image, 50, 50, Magick::OverCompositeOp)

    # Add fire reaction or smiley emoji
    # emoji_path = Rails.root.join('app', 'assets', 'images', 'fire_emoji.png') # Or smiley emoji path
    # emoji = Magick::Image.read(emoji_path).first
    # base_image.composite!(emoji, Magick::NorthWestGravity, 200, 370, Magick::OverCompositeOp)

    #   # Add rounded rectangle overlay for deal price
    #   draw = Magick::Draw.new
    #   draw.fill('white')
    #   draw.roundrectangle(50, 400, 350, 450, 10, 10)
    #   draw.draw(base_image)

    #  # Add text overlay for deal price
    #   draw.annotate(base_image, 0, 0, 50, 400, deal.price) do
    #     self.gravity = Magick::NorthWestGravity
    #     self.pointsize = 16
    #     self.font_family = 'Arial'
    #   end

    #   draw.annotate(base_image, 0, 0, 50, 430, "Price: $#{deal.price}") do
    #     self.gravity = Magick::NorthWestGravity
    #     self.pointsize = 16
    #     self.font_family = 'Arial'
    #   end

    #   draw.annotate(base_image, 0, 0, 50, 460, "Retail Price: $#{deal.retail_price}") do
    #     self.gravity = Magick::NorthWestGravity
    #     self.pointsize = 16
    #     self.font_family = 'Arial'
    #   end

    #   draw.annotate(base_image, 0, 0, 50, 490, "Store: #{deal.store.name}") do
    #     self.gravity = Magick::NorthWestGravity
    #     self.pointsize = 16
    #     self.font_family = 'Arial'
    #   end

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
    composite_image_path = Rails.root.join('public', 'deal_images', "#{deal.id}_composite.jpg")
    base_image.write(composite_image_path)

    # Return the path or URL of the composite image

    "/deal_images/#{deal.id}_composite.jpg"
  end

  def self.image_from_url(url)
    image_from_url = URI.open(url)
    img = Image.from_blob(image_from_url.read).first
  end

  def self.write_title(image, title)
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

  def self.write_text_in_center(img, text, options = {})
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

    # x = ((width - metrics.width) / 2.0)
    y = options[:y] || (height - metrics.height) / 2 + metrics.ascent

    # # Calculate the offset for precise centering
    # x_offset = (width - metrics.width) % 2
    # x += x_offset

    draw.annotate(img, width, 100, 0, y, text) do |d|
      d.gravity = options[:gravity] || Magick::CenterGravity
      d.fill = options[:color]
      d.pointsize = font_size
    end
  end

  def self.determine_base_image(social_media_type)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    Rails.root.join('app', 'assets', 'images', 'templates', img_name)
  end

  def self.overlay_image_in_center(main_img, overlay_img, options = {})
    # Get the dimensions of the main image
    main_width = main_img.columns
    main_height = main_img.rows

    overlay_width = 500
    overlay_height = options[:height] || 600

    overlay_img.resize_to_fit!(overlay_width, overlay_height)

    overlay_width = overlay_img.columns
    overlay_height = overlay_img.rows

    # Calculate the coordinates to place the overlay image in the center
    x = (main_width - overlay_width) / 2.0
    # y = (main_height - overlay_height) / 2
    y = options[:y] || 400

    # Calculate the scaling factor for the overlay image
    # scaling_factor = [main_width.to_f / overlay_width, main_height.to_f / overlay_height].min

    # Scale the overlay image to match the background image dimensions
    # overlay_img.scale!(scaling_factor)

    # Calculate the offset for precise centering
    # x_offset = (main_width - overlay_width) % 2
    # y_offset = (main_height - overlay_height) % 2

    # Apply the offset to the coordinates
    # x += x_offset
    # Composite the overlay image onto the main image
    main_img.composite!(overlay_img, x, y, Magick::OverCompositeOp)
  end

  def self.overlay_image(overlay, base_image)
    overlay = overlay.scale(0.7)
    base_image = base_image.composite(overlay, 100, 300, OverCompositeOp)
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
