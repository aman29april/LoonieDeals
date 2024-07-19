require 'feedjira'
require 'open-uri'
module External::Redflagdeals
  class Feed
    URL = "https://www.redflagdeals.com/rss/deals.php"
    DEFAULT_STORE = Store.other
    DEFAULT_CATEGORY = Category.other

    attr_reader :items
    def initialize
      @items = feed_data
      create_feed_entries!
    end


    def feed_data
      data = []

      xml = HTTParty.get(URL).body
      feed = Feedjira.parse(xml)

      if feed && feed.entries
        data = feed.entries.map do |entry|
          {
            title: entry.title,
            source_url: entry.url,
            published_at: entry.published.to_datetime,
            description: entry.summary,
            image: get_image(entry.summary),
            # deal_url: get_deal_url(entry.summary),
            categories: entry.categories,
          }
        end
      else
        Rails.logger.error("Failed to fetch or parse the feed: #{URL}")
      end

      rescue => e
        Rails.logger.error("Error fetching or parsing the feed: #{e.message}")

      return data
    end


    def create_feed_entries!
      # items = @items.first(1)
      @items.each do |item|
        unless FeedEntry.exists?(source_url: item[:source_url])
          tags = item[:categories]
          tags = filter_tags(tags)
          puts tags
          FeedEntry.create!(
            title: item[:title],
            source_url: item[:source_url],
            deal_url: item[:deal_url],
            description: sanitize_description(item[:description]),
            published_at: item[:published_at],
            tags: item[:categories],
            category_id: find_category(item[:categories]).id,
            store_id: find_store(item[:categories]).id,
            image: item[:image]
          )
        end
      end
    end

    private

    def filter_tags(tags)
      rejection_list = ['Canadian Deals & Coupons', 'Canadian Daily Deals', 'Canadian Discount Coupons Canada', 'Announcements']

      tags.reject! { |tag| rejection_list.include?(tag) }

      ignore_words = ['Coupons', 'flyers']
      tags.reject! do |tag|
        ignore_words.any?{|word| tag.include? word}
      end
      tags
    end

    def sanitize_description(html)
      doc = Nokogiri::HTML.fragment(html)

      # Remove image tags
      doc.css('img').remove

      # Remove anchor tags
      links = doc.css('a')
      links.last.remove

      doc = replace_short_urls(doc)
      doc = replace_amazon_affiliate_links(doc)
      doc = NokogiriDocUtil.add_target_blank(doc)

      # Remove p tags with specific text
      text_to_remove = /appeared first on/
      doc.css('p').each do |p|
        p.remove if text_to_remove.match? p.text
      end

      sanitized_html = doc.to_html
      sanitized_html
    end

    def get_image(content)
      doc = Nokogiri::HTML(content)
      image_src_list = doc.css('img').map { |img| img['src'] }
      return image_src_list.first if image_src_list.any?
    end

    def get_deal_url(content)
      doc = Nokogiri::HTML(content)
      link_text = /click here /
      link_href_list = doc.css('a')
      matching_links = link_href_list.find{ |link| link_text.match? link.text.downcase}
      return if matching_links.blank?

      sanitize_url(matching_links.attributes['href'].value)
    end

    def find_category(categories)
      cat = []
      categories.each do |category|
       cat << Category.search(category).first
      end
      cat.compact.first || DEFAULT_CATEGORY
    end

    def find_store(values)
      stores = []
      values.each do |value|
       stores << Store.search(value).first
      end
      create_missing_store(values) if stores.empty?
      stores.compact.first || DEFAULT_STORE
    end

    def create_missing_store(tags)
      return if MissingStore.find_by_name(tags.first).present?

      MissingStore.new(name: tags.first)
    end

    def replace_amazon_affiliate_links(doc)
      doc.css('a[href]').each do |link|
        href = link['href']
        link['href'] = sanitize_url(href)
      end
      doc
    end

    def sanitize_url(url)
      url_mappings = {
        'https://amzn.to/3KFfe8o': 'https://amzn.to/3UVKCIc',
        'https//amzn.to/3uSXu7d': 'https://amzn.to/3UVKCIc',
        'https://amzn.to/42YyAQ0': 'https://amzn.to/3UVKCIc',
        'https://amazon.smartcanucks.ca': ('/stores/amazon-ca'),
      }.with_indifferent_access


      matching_hash = url_mappings.find { |key, value| normalize_url(key) == normalize_url(url) }
      return url if matching_hash.blank?
      matching_hash[1]
    end

    def normalize_url(url)
      uri = URI.parse(url)
      normalized = "#{uri.host}#{uri.path}".gsub(/\/+\z/, '')
    end

    def absolute_url(relative_url)
      base_url = Rails.application.routes.default_url_options[:host]
      URI.join("http://#{base_url}", relative_url).to_s
    end


    def same_domain?(url1, url2)
      uri1 = URI.parse(url1)
      uri2 = URI.parse(url2)

      uri1.host == uri2.host
    end

    def replace_short_urls(doc)
      # Replace short URLs in anchor tags
      doc.css('a[href]').each do |link|
        short_url = link['href']
        long_url = expand_short_url(short_url)
        link['href'] = long_url
      end
      doc
    end

    def expand_short_url(short_url)
      response = HTTParty.head(short_url, follow_redirects: true)
      response.request.last_uri.to_s
    end

    def clean_affiliate(doc)
      doc.css('a[href]').each do |link|
        url = link['href']
        link['href'] = AffiliateUtil.replace_affiliate_tag(url, 'looniedeals08-20')
      end
    end

  end
end
