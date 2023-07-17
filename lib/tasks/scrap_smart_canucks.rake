# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'json'

namespace :scrap_smart_canucks do
  desc 'Fetch stores from smartcanucks'
  task get_store_data: [:environment] do |_, _args|
    response = HTTParty.get('https://deals.smartcanucks.ca/stores')

    if response.code != 200
      puts "Error: #{response.code}"
      exit
    end

    document = Nokogiri::HTML4(response.body)

    brands = document.css('.brand-card')
    brands_list = []

    brands.each do |brand|
      name = brand.at('.brand-logo-title').content.strip
      image = brand.at('.column-logo-style').attributes['src'].value

      brands_list << ({ name:, image: }) if name.present? && image.present?
    end

    brands_json = JSON.pretty_generate({ brands: brands_list })

    File.open('stores.json', 'w') { |f| f.write brands_json.to_s }
  end
end
