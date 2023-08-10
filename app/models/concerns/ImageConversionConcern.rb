# frozen_string_literal: true

module ImageConversionConcern
  extend ActiveSupport::Concern

  def convert_image_to_jpg(image, size = '512x512')
    return unless image.attached?

    # return if image.content_type != 'image/jpeg'

    converted_image = ImageConversionService.optimize(image, size)

    return if converted_image.blank?

    image.purge
    image.attach(io: File.open(converted_image.path), filename: 'converted_image.jpg')
  end
end
