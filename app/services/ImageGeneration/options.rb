# frozen_string_literal: true

module ImageGeneration
  class Options
    DEFAULT_OPTIONS = {
      title: { size: 65, color: '#063E66', y: 190, break_line: true },
      price: { size: 75, color: '#063E66', y: 1120, bold: true },
      coupon: { size: 40, color: 'white', y: 1140, x: 40, fill: 'black', stroke: '' },
      retail_price: { size: 45, color: '#063E66', y: 1120, x: 230, strike: true, gravity: nil },
      discount: { size: 45, color: '#FFFFFF', y: 1150, x: 950, fill: 'red' },
      store_name: { size: 50, color: '#063E66', y: 1630 },
      deal_image: { y: 400 },
      store_logo: { y: 1600, height: 170 }
    }.freeze

    POST_OPTIONS = {
      title: { size: 60, y: 100 },
      price: { size: 65, y: 820 },
      coupon: { size: 35, y: 820, x: 660 },
      retail_price: { size: 35, y: 820, x: 190 },
      discount: { size: 30, y: 1150, x: 950 },
      store_name: { size: 50, y: 1630 },
      deal_image: { y: 280, height: 500 },
      store_logo: { x: 30, y: 850, height: 130, width: 280 }
    }.freeze

    def self.for(type = 'STORY')
      options = DEFAULT_OPTIONS
      case type
      when 'STORY'
      when 'POST'
        options = options.deep_merge(POST_OPTIONS)
      end
      options
    end
  end
end
