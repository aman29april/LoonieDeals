# frozen_string_literal: true

module ImageGeneration
  colors = {
    white: 'white',
    blue: '#063E66'
  }.freeze

  fonts = {
    fjallaOne: 'FjallaOne-Regular',
    oswald: 'Oswald-Bold',
    openSans: 'OpenSans-Regular',
    poppins: 'Poppins-ExtraBold',
    anton: 'Anton-Regular'
  }.freeze

  COLORS = OpenStruct.new(colors)
  FONTS = OpenStruct.new(fonts)

  class Options
    DEFAULT_OPTIONS = {
      title: { size: 70, color: COLORS.blue, y: 190, break_line: true, bold: true, font: FONTS.anton,
               line_spacing: -25 },
      extra: { size: 50, color: '#01401a', break_line: false, font: FONTS.fjallaOne },
      subheading: { size: 50, color: '#f50c79', break_line: false, y: 335, font: FONTS.fjallaOne },
      short_slug: { size: 40, color: '#01401a', break_line: false, x: 470, y: 1750, font: FONTS.oswald },
      price: { size: 75, color: '#063E66', y: 1120, bold: true, font: FONTS.anton },
      coupon: { size: 40, color: 'white', y: 1140, x: 40, fill: 'black', stroke: '' },
      retail_price: { size: 45, color: '#063E66', y: 1120, x: 230, strike: true, gravity: nil },
      discount: { size: 45, color: '#FFFFFF', y: 1150, x: 950, fill: 'red' },
      store_name: { size: 50, color: '#063E66', y: 1630 },
      deal_image: { y: 470 },
      store_logo: { y: 1600, height: 170 }
    }.freeze

    POST_OPTIONS = {
      title: { size: 75, y: 100 },
      price: { size: 65, y: 820 },
      coupon: { size: 35, y: 820, x: 660 },
      short_slug: { x: 470, y: 920, bold: true },
      subheading: { size: 50, y: 220, size: 40 },
      retail_price: { size: 35, y: 820, x: 190 },
      discount: { size: 30, y: 850, x: 990 },
      store_name: { size: 50, y: 1630 },
      deal_image: { y: 290, height: 500 },
      store_logo: { x: 30, y: 850, height: 130, width: 280 }
    }.freeze

    THEMES = {
      dark: {
        title: { color: COLORS.white },
        price: { color: COLORS.white },
        discount: { color: COLORS.white },
        short_slug: { color: COLORS.white },
        extra: { color: COLORS.white },
        store_name: { color: COLORS.white }
      },
      light: {}
    }.freeze

    def self.for(type = 'story', theme = :light)
      options = DEFAULT_OPTIONS
      case type
      when 'story'
      when 'post'
        options = options.deep_merge(POST_OPTIONS)
      end
      colors = THEMES[theme.to_sym]
      options.deep_merge(colors)
    end
  end
end
