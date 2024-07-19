# frozen_string_literal: true

require 'RMagick'

module ImageGeneration
  class Collage
    ImageSize = Struct.new(:width, :height)

    # ImageSize.new(1080, 1080)
    def self.in_grid(images, image_size)
      padding = 20
      height = image_size.height
      width = image_size.width
      collage = Magick::ImageList.new

      height == 1920 ? 4 : 3
      cols = 3
      images.take(9).each_slice(cols).with_index do |row_images, col_index|
        row = Magick::ImageList.new

        row_images.each_with_index do |image_path, row_index|
          image = Magick::Image.read(image_path).first
          if col_index == 1 && row_index == 1
            # image = image.crop(150, 100, 1000, 820 )
            #  image = image.resize_to_fill(image.rows * factor, image.columns * factor)
            image = image.resize_to_fill(1100, 1600)

          end
          image = image.resize_to_fill(width, height)
          canvas = Magick::Image.new(width + padding, height + padding) { |img| img.background_color = 'white' }
          canvas.composite!(image, padding / 2, padding / 2, Magick::OverCompositeOp)
          row << canvas
        end

        collage.push(row.append(false))
      end

      collage = collage.append(true)
      collage = collage.resize_to_fill(width, height)

      name = 'collage.jpg'
      composite_image_path = Rails.root.join('public', 'deal_images', name)
      collage.write(composite_image_path)
      "/deal_images/#{name}"
    end

    def self.generate_collage(images)
      collage = Magick::Image.new(1080, 1080)

      # Calculate grid cell size
      cell_width = 1080 / 3
      cell_height = 1080 / 3

      # Calculate padding and usable area
      padding = 5
      width = cell_width - 2 * padding
      height = cell_height - 2 * padding

      # Composite with inner padding
      images.each_with_index do |image, index|
        img = Magick::Image.read(image).first
        img = img.resize_to_fit(width, height)

        x = (index % 3) * cell_width + padding
        y = (index / 3) * cell_height + padding

        collage.composite!(img, x, y, Magick::OverCompositeOp)
      end
      name = 'collage.jpg'
      composite_image_path = Rails.root.join('public', 'deal_images', name)
      collage.write(composite_image_path)
      "/deal_images/#{name}"
    end

    def self.preview(files, options = {})
      options = {
        columns: 5, # number of columns in collage
        scale_range: 0.1,            # ± to the thumb width
        thumb_width: 120,            # the width of thumbnail
        rotate_angle: 20, # maximal rotate angle
        background: 'white', # background of the collage
        border: 'gray20' # border color
      }.merge(options)

      # Produce collage from all the files in directory
      files = "#{files}/*" if File.directory?(files)
      imgs = ImageList.new
      # The placeholder for collage borders
      imgnull = Image.new(options[:thumb_width], options[:thumb_width]) do
        self.background_color = 'transparent'
      end
      # Top row
      (options[:columns] + 2).times { imgs << imgnull.dup }
      Dir.glob(files.to_s) do |f|
        # simply skip non-image files
        Image.read(f).each do |i|
          scale = (1.0 + options[:scale_range] * Random.rand(-1.0..1.0)) * options[:thumb_width] / [i.columns,
                                                                                                    i.rows].max
          # Placeholder if that’s the first column
          imgs << imgnull.dup if (imgs.size % (options[:columns] + 2)).zero?
          imgs << i.auto_orient.thumbnail(scale).polaroid(
            Random.rand(-options[:rotate_angle]..options[:rotate_angle])
          )
          # Placeholder if that’s the last columns
          imgs << imgnull.dup if (imgs.size % (options[:columns] + 2)) == options[:columns] + 1
        end
      rescue StandardError
        puts "Skipping error: #{$ERROR_INFO}"
      end
      # Fill the last row
      (2 * options[:columns] + 4 - (imgs.size % (options[:columns] + 2))).times { imgs << imgnull.dup }
      imgs.montage do
        self.tile             = Magick::Geometry.new(options[:columns] + 2)
        self.geometry         = "-#{options[:thumb_width] / 5}-#{options[:thumb_width] / 4}"
        self.background_color = options[:background]
      end.trim(true).border(10, 10, options[:background]).border(1, 1, options[:border])
    end
  end
end
