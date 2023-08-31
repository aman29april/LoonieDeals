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

  def self.resize(image, image_size)
    converted_image = Magick::Image.read(image.url).first
    converted_image.resize_to_fill(image_size.width, image_size.height)
  end

  def self.resize_and_save(file, name, image_size)
    image = resize(file, image_size)
    save_image(image, name)
  end

  def self.save_image(magickImage, file_name = nil)
    name = file_name
    name = tmp_name if file_name.blank?
    composite_image_path = Rails.root.join('public', 'deal_images', name)
    magickImage.write(composite_image_path)
    "/deal_images/#{name}"
  end

  def self.tmp_name
    Tempfile.new(['', '.jpg']).path.split('/').last
  end
end
