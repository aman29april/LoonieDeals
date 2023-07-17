# frozen_string_literal: true

require 'rmagick'

class ImageGenerationService
  include Rails.application.routes.url_helpers

  BASE_IMAGES = {
    'facebook' => 'facebook_base_image.jpg',
    'twitter' => 'twitter_base_image.jpg'
  }.freeze

  DEFAULT_BASE_IMAGE = 'story.png'
  FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'OpenSans-Regular.ttf').to_s

  def self.generate_deal_image(deal, social_media_type = 'story')
    ActiveStorage::Current.url_options = Rails.application.config.action_controller.default_url_options

    base_image_path = determine_base_image(social_media_type)
    deal_image_path = url_for(deal.image) # Assuming you have an image field in the Deal model
    base_image = MiniMagick::Image.open(base_image_path)
    deal_image = MiniMagick::Image.open(deal_image_path)

    # base_image.resize('800x600')

    # Resize the deal image if needed
    # deal_image.resize_to_fit!(400, 300)

    # Resize the deal image to fit within a specific width and height
    deal_image.resize('300x200^')
    deal_image.gravity('center')
    deal_image.extent('300x200')

    # Combine the base image and deal image
    base_image.composite(deal_image) do |c|
      c.compose 'Over'
      c.geometry '+250+100' # Adjust the position as needed
    end

    font_size = 100
    font_path = '../font.ttf'
    width_of_bounding_box = 600
    text_to_print = 'Hey this is some text!'

    # Create a new instance of the text wrap helper and give it all the
    # info the class needs..
    helper = RMagickTextWrapHelper.new(text_to_print, font_size, width_of_bounding_box, font_path)

    text = Draw.new
    text.pointsize = font_size
    text.gravity = NorthWestGravity
    text.fill = '#B22222'
    text.font = font_path

    # Call the "get_text_with_line_breaks" to get text
    # with line breaks where needed
    text_wit_line_breaks = helper.get_text_with_line_breaks

    text.annotate(base_image, 700, 700, 0, 0, text_wit_line_breaks)
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
    base_image.combine_options do |c|
      c.font FONT_PATH
      c.fill 'black'
      c.gravity 'northwest'
      c.pointsize 30
      c.draw "text 100,100 '#{deal.title}'"
      c.pointsize 24
      c.draw "text 100,150 'Price: $#{deal.price}'"
      c.draw "text 100,200 'Retail Price: $#{deal.retail_price}'"
      c.draw "text 100,250 'Store: #{deal.store.name}'"
    end

    # Save the composite image to a file or upload it to storage
    composite_image_path = Rails.root.join('public', 'deal_images', "#{deal.id}_composite.jpg")
    base_image.write(composite_image_path)

    # Return the path or URL of the composite image
    composite_image_path
  end

  def self.determine_base_image(social_media_type)
    img_name = BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
    Rails.root.join('app', 'assets', 'images', 'templates', img_name)
  end
end

include Magick

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
