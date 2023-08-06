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
  { name: 'VIA Rail', logo: 'VIA Rail.png', website: 'https://www.viarail.ca' },
  { name: 'Air Canada', logo: 'Air Canada.png', website: 'https://aircanada.com' },
  { name: '123 Ink', logo: '123 Ink.png', website: 'https://www.123ink.ca' },
  { name: 'PrimeCables', logo: 'PrimeCables.png', website: 'https://www.primecables.ca' },
  { name: 'Shopper Plus', logo: 'Shopper Plus.png', website: 'https://www.shopperplus.ca' },
  { name: 'KFC', logo: 'KFC.png', website: 'https://www.kfc.ca' },
  { name: 'Pizza Hut', logo: 'Pizza Hut.png', website: 'https://www.pizzahut.ca' },
  { name: 'Go Transit', logo: 'Go Transit.png', website: 'https://www.gotransit.com' },
  { name: 'Aritzia', logo: 'Aritzia.png', website: 'https://www.aritzia.com' },
  { name: 'Petro Canada', logo: 'Petro Canada.png', website: 'https://www.petro-canada.ca' },
  { name: 'Mirvish.com', logo: 'Mirvish.png', website: 'https://www.mirvish.com' },
  { name: 'Logitech', logo: 'Logitech.png', website: 'https://www.logitech.com' },
  { name: 'Simplii Financial', logo: 'Simplii Financial.png', website: 'https://www.simplii.com' },
  { name: 'Samsung', logo: 'Samsung.png', website: 'https://www.samsung.com/ca' },
  { name: 'Aldo', logo: 'Aldo.png', website: 'https://www.aldoshoes.com/ca/en' },
  { name: 'Rexall', logo: 'Rexall.png', website: 'https://www.rexall.ca' },
  { name: 'Toys R Us', logo: 'Toys R Us.png', website: 'https://www.toysrus.ca' },
  { name: 'Visions Electronics', logo: 'Visions Electronics.png', website: 'https://www.visions.ca/' },
  { name: 'Bell', logo: 'Bell.png', website: 'https://www.bell.ca' },
  { name: 'Rona', logo: 'Rona.png', website: 'https://www.tntsupermarket.com' },
  { name: 'T&T Supermarket', logo: 'TnT Supermarket.png', website: '' },
  { name: 'Newegg', logo: 'Newegg.png', website: 'https://www.newegg.ca' },
  { name: 'Food Basics', logo: 'Food Basics.png', website: 'https://www.foodbasics.ca/index.en.html' },
  { name: 'Real Canadian Superstore', logo: 'Real Canadian Superstore.png', website: '' },
  { name: 'Swoop', logo: 'Swoop.png', website: 'https://www.flyswoop.com' },
  { name: 'Flair Airlines', logo: 'Flair Airlines.png', website: 'https://flyflair.com' },
  { name: 'Porter', logo: 'Porter.png', website: 'https://www.flyporter.com' },
  { name: 'Lynx Air', logo: 'Lynx Air.png', website: 'https://www.flylynx.com' },
  { name: 'Groupon', logo: 'Groupon.png', website: 'https://www.groupon.ca' },
  { name: 'WagJag', logo: 'WagJag.png', website: 'https://www.wagjag.com' },
  { name: 'PUMA', logo: 'PUMA.png', website: 'https://ca.puma.com/' },
  { name: 'Crocs', logo: 'Crocs.png', website: 'https://www.crocs.ca' },
  { name: 'Columbia', logo: 'Columbia Sportswear.png', website: 'https://www.columbiasportswear.ca' },
  { name: 'Foot Locker', logo: 'Foot Locker.png', website: 'https://www.footlocker.ca' },
  { name: 'Temu', logo: 'Temu.png', website: 'https://www.temu.com' },
  { name: 'Uniqlo', logo: 'Uniqlo.png', website: 'https://www.uniqlo.com' },
  { name: 'Rakuten', logo: 'rakuten.png', website: 'https://www.rakuten.ca' },
  { name: 'AliExpress', logo: 'AliExpress.png', website: 'https://aliexpress.com' },
  { name: 'BlueNotes', logo: 'BlueNotes.png', website: 'https://blnts.com' },
  { name: 'Borrowell', logo: 'Borrowell.png', website: 'https://borrowell.com' },
  { name: "Carter's OshKosh B'gosh", logo: 'OshKosh.png', website: 'https://www.cartersoshkosh.ca' },
  { name: 'Indigo', logo: 'Indigo.png', website: 'https://www.chapters.indigo.ca' },
  { name: 'Coach', logo: 'Coach.png', website: 'https://ca.coach.com' },
  { name: 'Coach Outlet', logo: 'Coach Outlet.png', website: 'https://ca.coachoutlet.com' },
  { name: 'Decathlon', logo: 'Decathlon.png', website: 'https://www.decathlon.ca' },
  { name: 'Uber Eats', logo: 'Uber Eats.png', website: 'https://www.ubereats.com/ca' },
  { name: 'DoorDash', logo: 'DoorDash.png', website: 'https://www.doordash.com/en-CA' },
  { name: 'Uber', logo: 'Uber.png', website: 'https://www.uber.com' },
  { name: 'DSW', logo: 'DSW.png', website: 'https://www.dsw.ca' },
  { name: 'H&M', logo: 'H&M.png', website: 'https://www2.hm.com/en_ca/index.html' },
  { name: 'Instacart', logo: 'Instacart.png', website: 'https://www.instacart.ca' },
  { name: 'Jamieson', logo: 'Jamieson.png', website: 'https://www.jamiesonvitamins.com' },
  { name: 'Keurig', logo: 'Keurig.png', website: 'https://www.keurig.ca' },
  { name: 'LEGO', logo: 'LEGO.png', website: 'https://www.lego.com/en-ca' },
  { name: "Levi's", logo: 'Levis.png', website: 'https://www.levi.com/CA' },
  { name: 'Lucky Brand', logo: 'Lucky Brand.png', website: 'https://blnts.com' },
  { name: 'Mountain Warehouse', logo: 'Mountain Warehouse.png', website: 'https://www.mountainwarehouse.com/ca' },
  { name: 'Neo Financial', logo: 'Neo Financial.png', website: 'https://www.neofinancial.com' },
  { name: 'NordVPN', logo: 'NordVPN.png', website: 'https://nordvpn.com' },
  { name: 'Scotiabank', logo: 'Scotiabank.png', website: 'https://www.scotiabank.com' },
  { name: 'Sporting Life', logo: 'Sporting Life.png', website: 'https://www.sportinglife.ca' },
  { name: 'TELUS', logo: 'TELUS.png', website: 'https://www.telus.com' },
  { name: 'Ticketmaster', logo: 'Ticketmaster.png', website: 'https://www.ticketmaster.ca' },
  { name: 'UGG', logo: 'UGG.png', website: 'https://www.ugg.com' },
  { name: 'Under Armour', logo: 'Under Armour.png', website: 'https://www.underarmour.ca' },
  { name: 'TopCashback', logo: 'TopCashback.png', website: 'https://www.topcashback.com' },

  { name: 'MEC', logo: 'MEC.png', website: 'https://www.mec.ca' },
  { name: 'Google.com', logo: 'Google.png', website: 'https://store.google.com' },
  { name: 'Canada Goose', logo: 'Canada Goose.png', website: 'https://www.canadagoose.com' },
  { name: 'Public Mobile', logo: 'Public Mobile.png', website: 'https://www.publicmobile.ca' },
  { name: 'Target', logo: 'Target.png', website: 'https://www.target.com' },
  { name: 'Govee', logo: 'Govee.png', website: 'https://ca.govee.com' },
  { name: 'Tangerine', logo: 'Tangerine.png', website: 'https://tangerine.ca' },
  { name: 'Rogers', logo: 'Rogers.png', website: 'https://www.rogers.com' },
  { name: 'Toronto Island SUP', logo: 'Toronto Island SUP.png', website: 'https://www.torontoislandsup.com' },
  { name: 'Circle K', logo: 'Circle K.png', website: 'https://www.circlek.com' },
  { name: 'Virgin Mobile', logo: 'Virgin Mobile.png', website: 'https://www.virginmobile.ca' },
  { name: 'Fizz', logo: 'Fizz.png', website: 'https://fizz.ca' },
  { name: 'Running Free', logo: 'Running Free.png', website: 'https://www.runningfree.com' },
  { name: 'PC Optimum', logo: 'PC Optimum.png', website: 'https://www.pcoptimum.ca' },
  { name: 'B&H Photo Video', logo: 'B&H Photo Video.png', website: 'https://www.bhphotovideo.com' },
  { name: 'Timberland', logo: 'Timberland.png', website: 'https://www.timberland.ca' },
  { name: 'Humble Bundle', logo: 'Humble Bundle.png', website: 'https://www.humblebundle.com' },
  { name: 'Flight Deals', logo: '', website: '' },
  { name: 'TD Bank', logo: 'TD Bank.png', website: 'https://www.td.com' },
  { name: 'CNE', logo: 'CNE.png', website: 'https://www.theex.com' },
  { name: 'Kitchen Aid', logo: 'Kitchen Aid.png', website: 'https://www.kitchenaid.ca' },
  { name: 'Apple TV+', logo: 'Apple TV.png', website: 'https://tv.apple.com' },
  { name: 'Xbox', logo: 'Xbox.png', website: 'https://www.xbox.com' },
  { name: 'Skip The Dishes', logo: 'Skip The Dishes.png', website: 'https://www.skipthedishes.com' },
  { name: 'Canada Computers', logo: 'Canada Computer.png', website: 'https://www.canadacomputers.com' },
  { name: 'HSBC', logo: 'HSBC.png', website: 'https://www.hsbc.ca' },
  { name: 'Canadian Protein', logo: 'Canadian Protein.png', website: 'https://canadianprotein.com' },
  { name: 'Freedom Mobile', logo: 'Freedom Mobile.png', website: 'https://shop.freedommobile.ca' },
  { name: 'No Store', logo: '', website: '' },
  { name: "Canada's Wonderland", logo: 'Canadas Wonderland.png', website: 'https://www.canadaswonderland.com' },
  { name: "Wendy's", logo: 'Wendys.png', website: 'https://www.wendys.com' },
  { name: 'Pizza Pizza', logo: 'Pizza Pizza.png', website: 'https://www.pizzapizza.ca' },
  { name: 'CIBC', logo: 'CIBC.png', website: 'https://www.cibc.com' },
  { name: 'RBC', logo: 'RBC.png', website: 'https://www.rbcroyalbank.com' },
  { name: 'LCBO', logo: 'LCBO.png', website: 'https://www.lcbo.com' },
  { name: 'Audible.ca', logo: 'Audibleca.png', website: 'https://www.audible.ca' },
  { name: 'Beanfield', logo: 'Beanfield.png', website: 'https://www.beanfield.com' },
  { name: 'Rates.ca', logo: 'Ratesca.png', website: 'https://rates.ca' },
  { name: 'Starlink', logo: 'Starlink.png', website: 'https://www.starlink.com' },
  { name: 'Royal Canadian International Circus', logo: 'Royal Canadian International Circus.png',
    website: 'https://www.royalcanadiancircus.ca' },
  { name: 'WestJet', logo: 'WestJet.png', website: 'https://www.westjet.com' },
  { name: 'PetSmart', logo: 'PetSmart.png', website: 'https://www.petsmart.ca' },
  { name: 'Shaw', logo: 'Shaw.png', website: '' },
  { name: 'Adidas', logo: 'Adidas.png', website: 'https://www.adidas.ca' },
  { name: 'EQ Bank', logo: 'EQ Bank.png', website: 'https://www.eqbank.ca' },
  { name: "Montana's", logo: 'Montanas.png', website: 'https://www.montanas.ca' },
  { name: 'Home Hardware', logo: 'Home Hardware.png', website: 'https://www.homehardware.ca' },
  { name: 'Bulk Barn', logo: 'Bulk Barn.png', website: 'https://www.bulkbarn.ca' },
  { name: 'Buffalo Jeans', logo: 'Buffalo.png', website: 'https://www.buffalojeans.ca' },
  { name: 'Rabba', logo: 'Rabba.png', website: 'https://rabba.com/' },
  { name: 'Bath & Body Works', logo: 'Bath Body Works.png', website: 'https://www.bathandbodyworks.ca' },
  { name: "McDonald's", logo: 'McDonalds.png', website: 'https://www.mcdonalds.com/ca/en-ca.html' },
  { name: 'GUESS', logo: 'GUESS.png', website: 'https://www.guess.com/ca/en/home' },
  { name: 'GUESS Factory', logo: 'GUESS Factory.png', website: 'https://www.guessfactory.com/ca/en/home' },
  { name: 'Harry Rosen', logo: 'Harry Rosen.png', website: 'https://www.harryrosen.com' },
  { name: 'Hush Puppies', logo: 'Hush Puppies.png', website: 'https://www.hushpuppies.com/CA/en_CA/home' },
  { name: 'IT Cosmetics', logo: 'IT Cosmetics.png', website: 'https://www.itcosmetics.ca' },
  { name: 'JBL', logo: 'JBL.png', website: 'https://ca.jbl.com' },
  { name: 'Bose', logo: 'Bose.png', website: 'https://www.bose.ca/en/home' },
  { name: 'Kate Spade', logo: 'Kate Spade.png', website: 'https://www.katespade.com' },
  { name: 'Kate Spade Outlets', logo: 'Kate Spade.png', website: 'https://www.katespadeoutletcanadas.com' },
  { name: "Leon's", logo: 'Leons.png', website: 'https://www.leons.ca' },
  { name: 'NYX Canada', logo: 'NYX Canada.png', website: 'https://www.nyxcosmetics.ca' },
  { name: 'Ray-Ban', logo: 'Ray-Ban.png' },
  { name: 'Roots', logo: 'Roots.png', website: 'https://www.roots.com' },
  { name: 'Sony', logo: 'Sony.png', website: '' },
  { name: 'The Brick', logo: 'The Brick.png', website: 'https://www.thebrick.com' },
  { name: 'Vitamix', logo: 'Vitamix.png', website: '' },
  { name: 'ZARA', logo: 'ZARA.png', website: 'https://www.zara.com/ca' },
  { name: 'Well.ca', logo: 'Wellca.png', website: 'https://well.ca' },
  { name: 'Enterprise Rent-A-Car', logo: 'Enterprise Rent-A-Car.png', website: 'https://www.enterprise.ca' },
  { name: 'CityPASS', logo: 'CityPASS.png', website: 'https://www.citypass.com' },
  { name: 'Call It Spring', logo: 'Call It Spring.png', website: 'https://www.callitspring.com/ca/en' },
  { name: 'e.l.f. Cosmetics', logo: 'e.l.f. Cosmetics.png', website: 'https://www.elfcosmetics.com' },
  { name: 'Expedia.ca', logo: 'Expediaca.png', website: 'https://www.expedia.ca' },
  { name: 'iRobot', logo: 'iRobot.png', website: '' },
  { name: 'Kayak', logo: 'Kayak.png', website: '' },
  { name: 'FlixBus', logo: 'FlixBus.png', website: 'https://www.flixbus.ca' },
  { name: 'Mega Bus', logo: 'Mega Bus.png', website: 'https://ca.megabus.com' },
  { name: 'Metro', logo: 'Metro.png', website: '' },
  { name: 'Taco Bell', logo: 'Taco Bell.png', website: '' },
  { name: 'Toronto Public Library', logo: 'Toronto Public Library.png',
    website: 'https://www.torontopubliclibrary.ca' },
  { name: 'Baskin Robbins', logo: 'Baskin Robbins.png', website: '' },
  { name: 'Krispy Kreme', logo: 'Krispy Kreme.png', website: '' },
  { name: 'Destination Toronto', logo: 'Destination Toronto.png', website: 'https://www.destinationtoronto.com' },
  { name: 'MarbleSlab', logo: 'MarbleSlab.png', website: 'https://www.marbleslab.ca' },
  { name: 'Athleta', logo: 'Athleta.png', website: 'https://athleta.gapcanada.ca/' },
  { name: 'Disney Hotstar', logo: 'Disney Hotstar.png', website: '' },
  { name: 'Niagara Parks', logo: 'Niagara Parks.png', website: 'https://www.niagaraparks.com' },
  { name: '', logo: '.png', website: '' },
  { name: '', logo: '.png', website: '' },
  { name: '', logo: '.png', website: '' },
  { name: '', logo: '.png', website: '' },
  { name: '', logo: '.png', website: '' }

]
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
