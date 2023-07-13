require 'rmagick'

class ImageGenerationService

  BASE_IMAGES = {
    'facebook' => 'facebook_base_image.jpg',
    'twitter' => 'twitter_base_image.jpg'
  }.freeze

  DEFAULT_BASE_IMAGE = 'default_base_image.jpg'.freeze


  def self.generate_deal_image(deal, social_media_type)
    base_image_path = base_image_path = determine_base_image(social_media_type)
    deal_image_path = deal.image.url # Assuming you have an image field in the Deal model

    base_image = Magick::Image.read(base_image_path).first
    deal_image = Magick::Image.read(deal_image_path).first

    # Resize the deal image if needed
    deal_image.resize_to_fit!(400, 300)

    # Composite the deal image onto the base image
    base_image.composite!(deal_image, 50, 50, Magick::OverCompositeOp)

    # Add fire reaction or smiley emoji
    emoji_path = Rails.root.join('app', 'assets', 'images', 'fire_emoji.png') # Or smiley emoji path
    emoji = Magick::Image.read(emoji_path).first
    base_image.composite!(emoji, Magick::NorthWestGravity, 200, 370, Magick::OverCompositeOp)

    
    # Add rounded rectangle overlay for deal price
    draw = Magick::Draw.new
    draw.fill('white')
    draw.roundrectangle(50, 400, 350, 450, 10, 10)
    draw.draw(base_image)

   # Add text overlay for deal price
    draw.annotate(base_image, 0, 0, 50, 400, deal.price_with_discount) do
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 16
      self.font_family = 'Arial'
    end

    draw.annotate(base_image, 0, 0, 50, 430, "Price: $#{deal.price}") do
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 16
      self.font_family = 'Arial'
    end

    draw.annotate(base_image, 0, 0, 50, 460, "Retail Price: $#{deal.retail_price}") do
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 16
      self.font_family = 'Arial'
    end

    draw.annotate(base_image, 0, 0, 50, 490, "Store: #{deal.store.name}") do
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 16
      self.font_family = 'Arial'
    end


    # Add watermark
    watermark_path = Rails.root.join('app', 'assets', 'images', 'watermark.png')
    watermark = Magick::Image.read(watermark_path).first
    base_image.composite!(watermark, Magick::SouthEastGravity, 20, 20, Magick::OverCompositeOp)

    output_path = Rails.root.join('public', 'deal_images', "#{deal.id}_image.jpg")
    base_image.write(output_path)

    output_path.to_s
  end

  def self.determine_base_image(social_media_type)
    BASE_IMAGES[social_media_type] || DEFAULT_BASE_IMAGE
  end
end
