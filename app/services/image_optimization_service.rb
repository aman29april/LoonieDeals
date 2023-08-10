# frozen_string_literal: true

require 'mini_magick'

class ImageOptimizationService
  def self.optimize_image(image, size = '600x400>')
    optimized_image = MiniMagick::Image.new(image.tempfile.path)
    optimized_image.resize size
    optimized_image.quality 90
    optimized_image.write(optimized_image.path)

    optimized_image
  end
end
