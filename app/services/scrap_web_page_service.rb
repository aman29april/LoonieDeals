# frozen_string_literal: true

class ScrapWebPageService
  require 'httparty'

  attr_accessor :code, :body

  def initialize(url)
    @url = url
    uri = URI.parse(@url)

    headers = { 'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36',
                'Accept-Language': 'en-US, en;q=0.5' }

    response = HTTParty.get(uri, headers:)
    @code = response.code
    if response.code == 200
      @body = response.body
      @document = Nokogiri::HTML(@body)
    else
      puts "Error: #{@code} - #{response.message}"
    end
  end

  def get_html_content
    @body
  end

  def get_page_title
    title = @document.at_css('title').text
    title.split(':').first.strip if is_amazon?
  end

  def data
    json = {
      title: get_page_title
    }
    return json unless is_amazon?

    current_price, retail_price = get_price
    json.merge({
                 image: get_product_image,
                 current_price:,
                 retail_price:,
                 store_id: Store.find_by_name('Amazon.ca').id.to_s,
                 url: @url
               })
  end

  def get_product_image
    return unless is_amazon?

    img_wrapper = @document.at_css('[id="imgTagWrapperId"]')
    wrapper_img = img_wrapper.css('img').first
    return if wrapper_img.blank?

    wrapper_img['src'] || wrapper_img['data-old-hires']
  end

  def get_price
    return [nil, nil] unless is_amazon?

    price = at_selector(class: 'a-price-whole').text
    cents = at_selector(class: 'a-price-fraction').text
    current_price = clean_price([price, cents].join)

    retail_selector = at_selector(class: 'aok-relative')
    retail = retail_selector.present? && retail_selector.children.at_css('.a-offscreen').text
    retail_price = clean_price(retail)

    [current_price, retail_price]
  end

  def clean_price(prc)
    return if prc.blank?

    prc.delete(',').delete('$').to_f
  end

  def at_selector(option)
    @document.at_css("[#{option.keys.first}='#{option.values.first}']")
  end

  def is_amazon?
    @url.match?(/amazon/) || @url.match?(/amzn.to/)
  end
end
