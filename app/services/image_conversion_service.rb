# frozen_string_literal: true

require 'mini_magick'

class ImageConversionService
  include Rails.application.routes.url_helpers

  def self.to_jpg_and_resize(image, format = 'jpg')
    return image if image.content_type.include?(format)

    tempfile = image.download
    converted_image = MiniMagick::Image.read(tempfile)
    converted_image.resize('612x612')
    converted_image.strip
    converted_image.format(format)

    converted_image
  end

  def self.optimize(image, size = '512x512')
    tempfile = image.download
    return if tempfile.blank?

    converted_image = MiniMagick::Image.read(tempfile)
    converted_image.resize(size)
    converted_image.strip

    converted_image
  end
end
