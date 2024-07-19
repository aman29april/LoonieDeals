require 'feedjira'
require 'open-uri'
module External::Smartcanucks
  class Amazon
    # URL = "https://amazon.smartcanucks.ca/"
    URL = "https://deals.smartcanucks.ca/amazonca-canada"
    DEFAULT_CATEGORY = Category.other

    attr_reader :links
    def initialize
      @links = []
      fetch_amazon_links
      create_deals!
    end


    def fetch_amazon_links
      doc = NokogiriDocUtil.doc_from_url(URL)
      links = doc.css('a')
      amazon_links = links.select do |link|
        /www.amazon.ca\/dp/.match?(link.attributes['href']&.value)
      end

      @links = amazon_links.map {|link| link.attributes['href']&.value}
      rescue => e
        Rails.logger.error("Error fetching or parsing the feed: #{e.message}")

    end

    def create_deals!
      links = @links.first(1)
      @links.each do |link|
        data = ScrapWebPageService.new(link).data
        create_deal(data)
      end
    end

    private

    def create_deal(data)
      path = URI(data[:url]).path
      if Deal.amazon.created_within(2.days).with_url_pattern(path).any?
        puts "Deal already exists with path #{path}"
        return
      end

      deal = Deal.new(
        title: data[:title],
        store_id: data[:store_id],
        price: data[:current_price],
        retail_price: data[:retail_price],
        category: DEFAULT_CATEGORY,
        expiration_date: DateTime.now + 2.days,
        url: data[:url],
        starts_at: DateTime.now,
      )

      image = data[:image]
      if image.present? && UrlUtil.valid_uri?(image)
        deal.image.attach(io: URI.open(image), filename: 'image.jpg')
      end

      deal.save!

      rescue => e
        Rails.logger.error("Error creating deal #{e.message}")
    end

    def clean_affiliate(doc)
      doc.css('a[href]').each do |link|
        url = link['href']
        link['href'] = AffiliateUtil.replace_affiliate_tag(url, 'looniedeals08-20')
      end
    end

  end
end
