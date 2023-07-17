# frozen_string_literal: true

require 'mini_magick'

class ImageConversionService
  def self.convert_to_jpeg(image, format = 'jpg')
    converted_image = MiniMagick::Image.new(image.tempfile.path)
    converted_image.format(format)
    converted_image.strip
    converted_image
  end
end
