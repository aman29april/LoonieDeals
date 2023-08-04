# frozen_string_literal: true

class ScrapWebPageService
  require 'httparty'

  def self.get_html_content(url)
    uri = URI.parse(url)

    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true if uri.scheme == 'https'
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # request = Net::HTTP::Get.new(uri.request_uri)
    headers = { 'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36',
                'Accept-Language': 'en-US, en;q=0.5' }

    response = HTTParty.get(uri, headers:)

    return response.body if response.code == 200

    puts "Error: #{response.code} - #{response.message}"
    nil
  end
end
