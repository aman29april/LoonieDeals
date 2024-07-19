class FeedEntry < ApplicationRecord

  after_create do
    if Deal.where(starts_at: published_at, title: title).any?
      puts "Deal already exists"
    else
      # create_deal
    end

  end

  def create_deal
    deal = Deal.new(
      title: title,
      store_id: store_id,
      category_id: category_id,
      starts_at: published_at,
      expiration_date: published_at + 2.days,
      url: deal_url,
      body: description,
      large_image: true
    )

    if image.present? && UrlUtil.valid_uri?(image)
      deal.image.attach(io: URI.open(image), filename: 'image.jpg')
    end

    deal.save!

  rescue => e
    Rails.logger.error("Error creating deal #{e.message}")
  end

end
