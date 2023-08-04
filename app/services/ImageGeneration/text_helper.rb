# frozen_string_literal: true

module ImageGeneration
  class TextHelper
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
end
