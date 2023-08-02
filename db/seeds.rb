# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development? && !AdminUser.find_by(email: 'admin@example.com').present? && !AdminUser.find_by(email: 'admin@example.com').present?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
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

stores = [
  { name: 'Amazon.ca', logo: 'amazon.ca.png', website: 'https://amazon.ca' },
  { name: 'Dollarama', logo: 'Dollarama.png', website: 'https://www.dollarama.com' },
  { name: 'Sephora', logo: 'Sephora.png', website: 'https://www.sephora.com/ca/en' },
  { name: 'Old Navy', logo: 'Old Navy.png', website: 'https://oldnavy.gapcanada.ca' },
  { name: 'GAP', logo: 'GAP.png', website: 'https://www.gapcanada.ca' },
  { name: 'Dominos', logo: 'Dominos.png', website: 'https://dominos.ca' },
  { name: 'IKEA', logo: 'IKEA.png', website: 'https://www.ikea.com/ca' },
  { name: 'Walmart', logo: 'Walmart.png', website: 'https://walmart.ca' },
  { name: 'Costco', logo: 'Costco.png', website: 'https://www.costco.ca' },
  { name: 'Shopperplus', logo: 'Shopperplus.png', website: 'https://www.shopperplus.ca' },
  { name: 'Lenovo', logo: 'Lenovo.png', website: 'https://www.lenovo.com/ca/en' },
  { name: 'Best Buy', logo: 'Best Buy.png', website: 'https://www.bestbuy.ca/en-ca' },
  { name: 'No Frills', logo: 'No Frills.png', website: 'https://www.nofrills.ca' },
  { name: 'American Express', logo: 'American Express.png', website: 'https://www.americanexpress.com/en-ca' },
  { name: 'Staples', logo: 'Staples.png', website: 'https://www.staples.ca' },
  { name: 'Loblaws', logo: 'Loblaws.png', website: 'https://www.loblaws.ca' },
  { name: 'Home Depot', logo: 'Home Depot.png', website: 'https://www.homedepot.ca' },
  { name: 'The Source', logo: 'The Source.png', website: 'https://www.thesource.ca' },
  { name: 'Princess Auto', logo: 'Princess Auto.png', website: 'https://www.princessauto.com' },
  { name: 'Ardene', logo: 'Ardene.png', website: 'https://www.ardene.com' },
  { name: 'Lululemon', logo: 'Lululemon.png', website: 'https://shop.lululemon.com' },
  { name: 'London Drugs', logo: 'London Drugs.png', website: 'https://www.londondrugs.com' },
  { name: 'Starbucks', logo: 'Starbucks.png', website: 'https://www.starbucks.ca' },
  { name: 'Subway', logo: 'Subway.png', website: 'https://www.subway.com/en-ca' },
  { name: "Mark's", logo: 'Marks.png', website: 'https://www.marks.com' },
  { name: 'Sport Chek', logo: 'Sport Chek.png', website: 'https://www.sportchek.ca' },
  { name: 'Skechers', logo: 'Skechers.png', website: 'https://www.skechers.ca' },
  { name: 'Eddie Bauer', logo: 'Eddie Bauer.png', website: 'https://www.eddiebauer.ca' },
  { name: 'The Bay', logo: 'The Bay.svg', website: 'https://www.thebay.com' },
  { name: 'Cineplex', logo: 'Cineplex.png', website: 'https://www.cineplex.com' },
  { name: 'Michaels Canada', logo: 'Michaels Canada.svg', website: 'https://canada.michaels.com' },
  { name: 'Tim Hortons', logo: 'Tim Hortons.png', website: 'https://www.timhortons.com' },
  { name: 'The Body Shop', logo: 'The Body Shop.png', website: 'https://www.thebodyshop.com/en-ca' },
  { name: 'Calvin Klein', logo: 'Calvin Klein.png', website: 'https://www.calvinklein.ca' },
  { name: 'Clarks', logo: 'Clarks.png', website: 'https://www.clarkscanada.com' },
  { name: 'Freshco', logo: 'Freshco.png', website: 'https://freshco.com' },
  { name: 'Le Chateau', logo: 'Le Chateau.png', website: 'https://suzyshier.com/pages/le-chateau' },
  { name: 'Suzy Shier', logo: 'Suzy Shier.png', website: 'https://suzyshier.com' },
  { name: 'Linen Chest', logo: 'Linen Chest.png', website: 'https://www.linenchest.com' },
  { name: 'Shoppers Drug Mart', logo: 'Shoppers Drug Mart.png', website: 'https://www.shoppersdrugmart.ca' },
  { name: 'Perkopolis', logo: 'Perkopolis.png', website: 'https://www.perkopolis.com' },
  { name: 'Wealthsimple', logo: 'Wealthsimple.png', website: 'https://www.wealthsimple.com' },
  { name: 'Fido', logo: 'Fido.png', website: 'https://www.fido.ca' },
  { name: 'MAC Cosmetics', logo: 'MAC Cosmetics.png', website: 'https://www.maccosmetics.ca' },
  { name: 'VIA Rail', logo: 'VIA Rail.png', website: 'https://www.viarail.ca' }
]
stores.each do |store_data|
  store = Store.find_or_initialize_by(name: store_data[:name])
  store.website = store_data[:website]
  puts "Store Name: #{store.name}"
  if store.persisted?
    puts 'SKIPPING>>>> STORE already present.'
    store.save!
    next
  end
  filename = store_data[:logo]
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
    url: 'https://www.amazon.ca/fire-tv-stick-4k-max-with-alexa-voice-remote/dp/B08MR2C1T7?crid=183LMCE4K6PAQ&keywords=fire+stick&qid=1690694153&sprefix=fire+stick%2Caps%2C97&sr=8-2&linkCode=ll1&tag=looniedeals01-20&linkId=878bc4876945c23f38005f1b46682cfe&language=en_CA&ref_=as_li_ss_tl',
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
