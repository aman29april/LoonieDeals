# frozen_string_literal: true

module ImageConversionConcern
  extend ActiveSupport::Concern

  def convert_image_to_jpg(image)
    return unless image.attached?

    return unless image.content_type != 'image/jpeg'

    converted_image = ImageConversionService.convert_to_jpg(image)

    image.purge
    image.attach(io: File.open(converted_image.path), filename: 'converted_image.jpg')
  end
end
