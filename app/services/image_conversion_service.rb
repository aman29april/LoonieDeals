# frozen_string_literal: true

require 'mini_magick'

class ImageConversionService
  include Rails.application.routes.url_helpers

  def self.convert_to_jpg(image, format = 'jpg')
    return image if image.content_type.include?(format)

    tempfile = image.download
    converted_image = MiniMagick::Image.read(tempfile)
    converted_image.format(format)

    converted_image
  end
end
