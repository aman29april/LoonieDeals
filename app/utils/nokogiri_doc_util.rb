module NokogiriDocUtil

  def self.add_target_blank(doc)
    # Iterate over each link element and add target="_blank"
    doc.css('a').each do |link|
      link['target'] = '_blank' unless link['target'] == '_blank'
    end

    doc
  end

  def self.doc_from_url(url)
    uri = URI.parse(url)

    headers = { 'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36',
                'Accept-Language': 'en-US, en;q=0.5' }

    response = HTTParty.get(uri, headers:)
    code = response.code
    if code == 200
      return Nokogiri::HTML(response.body)
    else
      puts "Error: #{code} - #{response.message}"
    end
  end
end
