# frozen_string_literal: true

class AmazonListingService
  LIST = {
    "Apps & Games": 'mobile-apps',
    "Automotive": 'automotive',
    "Baby": 'baby',
    "Beauty": 'beauty',
    "Books": 'stripbooks',
    "Clothing & Accessories": 'apparel',
    "Electronics": 'electronics',
    "Gift Cards": 'gift-cards',
    "Grocery & Gourmet Food": 'grocery',
    "Health & Personal Care": 'hpc',
    "Home & Kitchen": 'kitchen',
    "Industrial & Scientific": 'industrial',
    "Jewelry": 'jewelry',
    "Kindle Store": 'digital-text',
    "Luggage & Bags": 'luggage',
    "Movies & TV": 'dvd',
    "Music": 'popular',
    "Musical Instruments, Studio": 'mi',
    "Office Products": 'office-products',
    "Patio, Lawn & Garden": 'lawngarden',
    "Pet Supplies": 'pets',
    "Shoes & Handbags": 'shoes',
    "Software": 'software',
    "Sports & Outdoors": 'sporting',
    "Tools & Home Improvement": 'tools',
    "Toys & Games": 'toys',
    "Video Games": 'videogames',
    "Watches": 'watches'
  }.freeze

  SORT_BY = {
    "Relevance": 'relevancerank',
    'Popularity': 'popularity-rank',
    'Price: Low to High': 'price-asc-rank',
    'Price: High to Low': 'price-desc-rank',
    'Avg. Customer Review': 'review-rank',
    'Newest Arrivals': 'date-desc-rank'
  }.freeze

  AVG_REVIEWS = {
    '5 Stars Only': '5-',
    '4 Stars & Up': '4-',
    '3 Stars & Up': '3-',
    '2 Stars & Up': '2-',
    '1 Star & Up': '1-'
  }.freeze

  FILTER_PRICE = {
    'Amazon Prices Only': 1,
    'Prices From All Merchants': 0
  }.freeze
end
