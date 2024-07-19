# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development? && !AdminUser.find_by(email: 'admin@example.com').present?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

if Rails.env.production? && !AdminUser.find_by(email: 'aman29april@gmail.com').present?
  AdminUser.create!(email: 'aman29april@gmail.com', password: 'password',
                    password_confirmation: 'password')
end

categories = %(Autos
  Babies & Kids
  Bags & Luggage
  Books & Magzines
  Clothing & Accessories
  Computers
  Education
  Entertainment
  Finance
  Flowers & Gifts
  Freebies
  Grocery
  Health & Beauty
  Home & Home Improvement
  Movies
  Occasions
  Office & School Supplies
  Other
  Pets
  Phones
  Restaurants
  Services
  Shoes
  Sporting Goods
  Tech & Electronics
  Travel & Vacations
  TV
  Video Games).split("\n")

categories.each do |name|
  Category.find_or_create_by!(name: name.strip)
end

include 'stores'
stores.each do |store_data|
  next if store_data[:name].blank?

  store = Store.find_or_initialize_by(name: store_data[:name])
  store.website = store_data[:website]
  puts "Store Name: #{store.name}"
  if store.persisted?
    puts 'SKIPPING>>>> STORE already present.'
    store.save!
    next
  end
  filename = store_data[:logo]
  if filename.blank?
    store.save!
    next
  end
  image = Rails.root.join('app', 'assets', 'images', 'stores', filename)
  store.image.attach(io: File.open(image), filename:)
  store.save!

  puts "Added store #{store.name}"
end

deals = [
  {
    title: 'Large 4 topping pizza',
    store: Store.find_by_name('Dominos'),
    price: 14.99,
    retail_price: 21.99,
    coupon: '4201',
    url: 'https://www.dominos.ca',
    category: Category.find_by_name('Restaurants'),
    image: 'dominos.jpg'
  },
  {
    title: 'Amazon Fire HD 8 tablet, 8” HD Display, 32 GB',
    store: Store.find_by_name('Amazon.ca'),
    price: 99.99,
    retail_price: 119.99,
    url: 'https://amzn.to/3KiOlt8',
    category: Category.find_by_name('Tech & Electronics'),
    image: 'amazon tablet.jpg'
  },
  {
    title: 'Fire TV Stick 4K Max streaming device, Wi-Fi 6, Alexa Voice Remote',
    store: Store.find_by_name('Amazon.ca'),
    price: 25.99,
    retail_price: 79.99,
    url: 'https://www.amazon.ca/fire-tv-stick-4k-max-with-alexa-voice-remote/dp/B08MR2C1T7?crid=183LMCE4K6PAQ&keywords=fire+stick&qid=1690694153&sprefix=fire+stick%2Caps%2C97&sr=8-2&linkCode=ll1&tag=looniedeals08-20&linkId=878bc4876945c23f38005f1b46682cfe&language=en_CA&ref_=as_li_ss_tl',
    category: Category.find_by_name('Tech & Electronics'),
    image: 'fire stick.jpg'
  },
  {
    title: 'Cineplex Family Favourite Deal: Movies Every Saturday for $2.99',
    store: Store.find_by_name('Cineplex'),
    price: 2.99,
    url: 'https://www.cineplex.com/events/family',
    category: Category.find_by_name('Entertainment'),
    image: 'cineplex.jpg'
  },
  {
    title: '50% off sitewide',
    store: Store.find_by_name('Old Navy'),
    discount: 50,
    category: Category.find_by_name('Clothing & Accessories'),
    image: 'old navy.jpg'
  },
  {
    title: '25% off your Favourite Cold Drink Wednesdays After 12 p.m.',
    store: Store.find_by_name('Starbucks'),
    price: 3.99,
    retail_price: 6.99,
    category: Category.find_by_name('Restaurants'),
    image: 'Starbucks.jpg'
  },
  {
    title: 'VIA Rail Canada Discount Tuesday: Kids 2-11 Travel at 50% off + Save 10% – 15% off in the Corridor & Regional Trains',
    store: Store.find_by_name('VIA Rail'),
    coupon: 'TUESDAY',
    url: 'https://www.viarail.ca/en',
    category: Category.find_by_name('Travel & Vacations'),
    image: 'via rail.jpg'
  }
]

deals.each do |deal_data|
  deal = Deal.find_or_initialize_by(deal_data.except(:image))
  puts "Deal Name: #{deal.title}"
  if deal.persisted?
    puts 'SKIPPING>>>> Deal already present.'
    next
  end
  filename = deal_data[:image]
  image = Rails.root.join('app', 'assets', 'images', 'deals', filename)
  deal.image.attach(io: File.open(image), filename:)
  deal.save!
end

Link.create(label: '', url: '', pinned: true, enabled: true)
