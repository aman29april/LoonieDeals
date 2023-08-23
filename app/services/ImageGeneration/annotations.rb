# frozen_string_literal: true

module ImageGeneration
  module Annotations
    FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'OpenSans-Regular.ttf').to_s

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

    def write_text_in_center(img, text, options = {})
      # Get the image dimensions
      width = img.columns
      height = img.rows

      font_size = options[:size]
      font = options[:font]
      font = 'OpenSans-Regular' if font.blank?
      font_path = get_font_path(font)

      draw = Magick::Draw.new

      if options[:break_line]
        width_of_bounding_box = width
        text = ImageGeneration::TextHelper.new(text, font_size, width_of_bounding_box,
                                               font_path).get_text_with_line_breaks
      end
      # Calculate the coordinates to place the text in the center
      metrics = draw.get_multiline_type_metrics(text)
      x = options[:x] || 0
      y = options[:y] || (height - metrics.height) / 2 + metrics.ascent

      draw.annotate(img, width, 100, x, y, text) do |d|
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

    def add_text_inside_rounded_rectangle(img, text, options)
      width = img.columns
      img.rows
      text_draw = Magick::Draw.new
      text_draw.pointsize = options[:size] || 24
      text_draw.font_weight = Magick::BoldWeight

      metrics = text_draw.get_multiline_type_metrics(text)
      metrics.width
      metrics.height

      fill_color = options[:fill] || '#CC0C39'
      stroke_color = options[:stroke] || 'white'
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

      corner_size = options[:corner_radius] || 20
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

    def overlay_image_in_center(main_img, overlay_img, options = {})
      return main_img if options[:hidden].present?

      main_width = main_img.columns
      main_height = main_img.rows

      enlarge_factor = options[:enlarge_image_by] || 0

      width = options[:width] || 600
      overlay_width = (options[:image_full_with] ? main_width : width) + enlarge_factor
      overlay_height = (options[:height] || 600) + enlarge_factor

      overlay_img.resize_to_fit!(overlay_width, overlay_height)

      overlay_width = overlay_img.columns
      overlay_img.rows

      # Calculate the coordinates to place the overlay image in the center
      x = options[:x] || (main_width - overlay_width) / 2.0
      center_y = (main_height - overlay_height) / 2
      y = options[:y] || center_y # 400

      y += options[:y_offset].to_i

      overlay_img = add_background_color(overlay_img) if options[:with_background]

      main_img.composite!(overlay_img, x, y, Magick::OverCompositeOp)
    end

    def add_background_color(image, background_color = 'white')
      width = image.columns
      height = image.rows
      background_image = Magick::Image.new(width, height) do |img|
        img.background_color = background_color
      end
      background_image.composite(image, 0, 0, Magick::OverCompositeOp)
    end

    def get_font_path(name)
      "#{Rails.root}/app/assets/fonts/#{name}.ttf"
    end

    def image_from_url(url)
      image_from_url = URI.open(url)
      Image.from_blob(image_from_url.read).first
    end

    def svg_to_png(url)
      svg_string = URI(url).read
      png = convert_svg_to_png(svg_string)
      Magick::Image.from_blob(png).first
    end
  end
end
