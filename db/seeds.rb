# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

# Seed data for Exchange model
nasdaq = Exchange.create(name: 'NASDAQ', country: 'US', currency: 'USD')
nyse = Exchange.create(name: 'NYSE', country: 'US', currency: 'USD')
tse = Exchange.create(name: 'TSE', country: 'Canada', currency: 'CAD')
nse = Exchange.create(name: 'NSE', country: 'India', currency: 'INR')
bse = Exchange.create(name: 'BSE', country: 'India', currency: 'INR')

# Create sectors
tech = Sector.create(name: 'Technology')
healthcare = Sector.create(name: 'Healthcare')
finance = Sector.create(name: 'Finance')
public_utilities = Sector.create(name: 'Public Utilities')
consumer_services = Sector.create(name: 'Consumer Services')
capital_goods = Sector.create(name: 'Capital Goods')
consumer_durables = Sector.create(name: 'Consumer Durables')
consumer_non_durables = Sector.create(name: 'Consumer Non-Durables')
miscellaneous = Sector.create(name: 'Miscellaneous')
energy = Sector.create(name: 'Energy')
transportation = Sector.create(name: 'Transportation')
basic = Sector.create(name: 'Basic Industries')
consumer_cyclical = Sector.create(name: 'Consumer Cyclical')

consumer_cyclical.industries.create(name: 'Auto Manufacturers')

# create Industries

['EDP Services',
 'Computer Manufacturing',
 'Computer Software: Prepackaged Software',
 'Computer Software: Programming, Data Processing',
 'Computer Communications Equipment',
 'Industrial Machinery/Components'].each do |name|
  tech.industries.create(name:)
end

healthcare.industries.create(name: 'Medical Specialities')
healthcare.industries.create(name: 'Medical/Dental Instruments')
healthcare.industries.create(name: 'Major Pharmaceuticals')

['Life Insurance',
 'Accident &Health Insurance',
 'Property-Casualty Insurers',
 'Major Banks',
 'Savings Institutions'].each do |name|
  finance.industries.create(name:)
end

basic.industries.create(name: 'Textiles')

['Business Services',
 'Industrial Machinery/Components',
 'Multi-Sector Companies'].each do |name|
  miscellaneous.industries.create(name:)
end

energy.industries.create(name: 'Oil & Gas Production')
energy.industries.create(name: 'Natural Gas Distribution')

consumer_services.industries.create(name: 'Real Estate Investment Trusts')

consumer_durables.industries.create(name: 'Automotive Aftermarket')

['Homebuilding',
 'Auto Parts:O.E.M.',
 'Industrial Machinery/Components'].each do |name|
  capital_goods.industries.create(name:)
end

transportation.industries.create(name: 'Marine Transportation')

# Create quotes
aapl = Company.create!(ticker: 'AAPL',
                       name: 'Apple Inc.',
                       exchange: nasdaq,
                       sector: tech,
                       industry: tech.industries.find_by(name: 'Computer Manufacturing'),
                       beta: 1.4,
                       website: 'https://www.apple.com/',
                       employees: 164_000,
                       founded: Date.new(1976, 0o4, 1),
                       market_cap: 2_809_169_200_200,
                       ipo_year: 1980,
                       ceo: 'Tim Cook',
                       description: "Apple Inc. is an American multinational technology company headquartered in Cupertino, California. Apple is the world's largest technology company by revenue, with US$394.3 billion in 2022 revenue. As of March 2023, Apple is the world's biggest company by market capitalization. As of June 2022, Apple is the fourth-largest personal computer vendor by unit sales and second-largest mobile phone manufacturer. It is one of the Big Five American information technology companies, alongside Alphabet Inc., Amazon, Meta Platforms, and Microsoft. Apple was founded as Apple Computer Company on April 1, 1976, by Steve Wozniak, Steve Jobs and Ronald Wayne to develop and sell Wozniak's Apple I personal computer. It was incorporated by Jobs and Wozniak as Apple Computer, Inc. in 1977. The company's second computer, the Apple II, became a best seller and one of the first mass-produced microcomputers. Apple went public in 1980 to instant financial success. The company developed computers featuring innovative graphical user interfaces, including the 1984 original Macintosh, announced that year in a critically acclaimed advertisement",
                       address: 'Cupertino, California, United States',
                       exchange_url: 'https://www.nasdaq.com/symbol/aapl',
                       pe_ratio: 27.51,
                       forward_pe_ratio: 27.22,
                       earnings_per_share: 5.89,
                       dividend_yield: 0.56,
                       l52w_high: 176.15,
                       l52w_low: 124.17,
                       open_price: 124.17,
                       close_price: 132.22,
                       volume: 65_706_406)

goog = Company.create(ticker: 'GOOG', name: 'Alphabet Inc.', exchange: nyse, sector: tech)
msft = Company.create(ticker: 'MSFT', name: 'Microsoft Corporation', exchange: nasdaq, sector: tech)
jnj = Company.create(ticker: 'JNJ', name: 'Johnson & Johnson', exchange: nasdaq, sector: healthcare)
pfe = Company.create(ticker: 'PFE', name: 'Pfizer Inc.', exchange: nasdaq, sector: healthcare)
jpm = Company.create(ticker: 'JPM', name: 'JPMorgan Chase & Co.', exchange: nasdaq, sector: finance)
wfc = Company.create(ticker: 'WFC', name: 'Wells Fargo & Company', exchange: nasdaq, sector: finance)
amzn = Company.create(ticker: 'AMZN', name: 'Amazon.com, Inc.', exchange: nyse, sector: tech)
tsla = Company.create(ticker: 'TSLA', name: 'Tesla Inc', exchange: nasdaq,
                      sector: consumer_cyclical,
                      description: 'Founded in 2003 and based in Palo Alto, California, Tesla is a vertically integrated sustainable energy company that also aims to transition the world to electric mobility by making electric vehicles. The company sells solar panels and solar roofs for energy generation plus batteries for stationary storage for residential and commercial properties including utilities. Tesla has multiple vehicles in its fleet, which include luxury and midsize sedans and crossover SUVs. The company also plans to begin selling more affordable sedans and small SUVs, a light truck, a semi truck, and a sports car. Global deliveries in 2022 were a little over 1.3 million vehicles.',
                      ipo_year: 2010,
                      address: 'Austin, Texas',
                      ceo: 'Mr. Elon R. Musk',
                      website: 'https://www.tesla.com/',
                      beta: 2.9)

# create peers
# amzn.peers << [aapl, goog, msft]
# amzn.save!

# Seed Financial Statements for AAPL
# aapl_bs1 = BalanceSheet.create!(
#   currency: 'USD',
#   cik: '0000320193',
#   filling_date: '2023-02-03',
#   accepted_date: '2023-02-02 18:01:30',
#   calendar_year: 2023,
#   period: 'Q1',
#   cash_and_cash_equivalents: 20_535_000_000,
#   short_term_investments: 30_820_000_000,
#   cash_and_short_term_investments: 51_355_000_000,
#   net_receivables: 54_180_000_000,
#   inventory: 6_820_000_000,
#   other_current_assets: 16_422_000_000,
#   total_current_assets: 128_777_000_000,
#   property_plant_equipment_net: 42_951_000_000,
#   goodwill: 0,
#   intangible_assets: 0,
#   goodwill_and_intangible_assets: 0,
#   long_term_investments: 114_095_000_000,
#   tax_assets: 0,
#   other_non_current_assets: 60_924_000_000,
#   total_non_current_assets: 217_970_000_000,
#   other_assets: 0,
#   total_assets: 346_747_000_000,
#   account_payables: 57_918_000_000,
#   short_term_debt: 11_483_000_000,
#   tax_payables: 0,
#   deferred_revenue: 7_992_000_000,
#   other_current_liabilities: 59_893_000_000,
#   total_current_liabilities: 137_286_000_000,
#   long_term_debt: 99_627_000_000,
#   deferred_revenue_non_current: 0,
#   deferred_tax_liabilities_non_current: 0,
#   other_non_current_liabilities: 53_107_000_000,
#   total_non_current_liabilities: 152_734_000_000,
#   other_liabilities: 0,
#   capital_lease_obligations: 0,
#   total_liabilities: 290_020_000_000,
#   preferred_stock: 0,
#   common_stock: 66_399_000_000,
#   retained_earnings: 3_240_000_000,
#   accumulated_other_comprehensive_income_loss: -12_912_000_000,
#   othertotal_stockholders_equity: 0,
#   total_stockholders_equity: 56_727_000_000,
#   total_equity: 56_727_000_000,
#   total_liabilities_and_stockholders_equity: 346_747_000_000,
#   minority_interest: 0,
#   total_liabilities_and_total_equity: 346_747_000_000,
#   total_investments: 144_915_000_000,
#   total_debt: 111_110_000_000,
#   net_debt: 90_575_000_000,
#   link: 'https://www.sec.gov/Archives/edgar/data/320193/000032019323000006/0000320193-23-000006-index.htm',
#   final_link: 'https://www.sec.gov/Archives/edgar/data/320193/000032019323000006/aapl-20221231.htm',
#   quote: aapl
# )
# aapl_bs2 = BalanceSheet.create!(
#   # date: Date.new(2020, 12, 31),
#   fiscal_year: 2020,
#   fiscal_quarter: 4,
#   total_assets: 323_888_000_000,
#   total_liabilities: 162_810_000_000,
#   total_equity: 161_078_000_000,
#   quote: aapl
# )
# BalanceSheet.create!(
#   # date: Date.new(2021, 12, 31),
#   fiscal_year: 2022,
#   fiscal_quarter: 4,
#   total_assets: 354_054_000_000,
#   total_liabilities: -180_856_000_000,
#   total_equity: 173_198_000_000,
#   quote: aapl
# )
# BalanceSheet.create!(
#   # date: Date.new(2021, 12, 31),
#   fiscal_year: 2023,
#   fiscal_quarter: 1,
#   total_assets: 354_054_000_000,
#   total_liabilities: -180_856_000_000,
#   total_equity: 173_198_000_000,
#   quote: aapl
# )
# aapl_cf1 = CashFlow.create!(
#   # date: Date.new(2021, 12, 31),
#   fiscal_year: 2021,
#   fiscal_quarter: 4,
#   cash_from_operating_activities: 104_956_000_000,
#   cash_from_investing_activities: -51_597_000_000,
#   cash_from_financing_activities: -56_508_000_000,
#   quote: aapl
# )
# aapl_cf2 = CashFlow.create!(
#   # date: Date.new(2020, 12, 31),
#   fiscal_year: 2020,
#   fiscal_quarter: 4,
#   cash_from_operating_activities: 80_674_000_000,
#   cash_from_investing_activities: -42_830_000_000,
#   cash_from_financing_activities: -7_320_000_000,
#   quote: aapl
# )
# aapl_pl1 = ProfitAndLossStatement.create!(
#   # date: Date.new(2021, 12, 31),
#   fiscal_year: 2021,
#   fiscal_quarter: 4,
#   total_revenue: 123_779_000_000,
#   cost_of_revenue: 84_739_000_000,
#   gross_profit: 39_040_000_000,
#   operating_expenses: 10_139_000_000,
#   operating_income: 24_610_000_000,
#   net_income: 24_610_000_000,
#   quote: aapl
# )
# aapl_pl2 = ProfitAndLossStatement.create!(
#   # date: Date.new(2020, 12, 31),
#   fiscal_year: 2020,
#   fiscal_quarter: 4,
#   total_revenue: 111_439_000_000,
#   cost_of_revenue: 75_879_000_000,
#   gross_profit: 35_560_000_000,
#   operating_expenses: 9_685_000_000,
#   operating_income: 24_610_000_000,
#   net_income: 57_411_000_000,
#   quote: aapl
# )
# aapl.balance_sheets << [aapl_bs1, aapl_bs2]
# aapl.cash_flows << [aapl_cf1, aapl_cf2]
# aapl.profit_and_loss_statements << [aapl_pl1, aapl_pl2]

# Seed Financial Statements for amzn
# balance_sheet1 = BalanceSheet.create(
#   quote_id: aapl.id,
#   fiscal_year: 2020,
#   fiscal_quarter: 4,
#   cash_and_cash_equivalents: 8_453_000_000,
#   short_term_investments: 145_000_000,
#   net_receivables: 24_504_000_000,
#   inventory: 19_782_000_000,
#   total_current_assets: 40_620_000_000,
#   long_term_investments: 40_478_000_000,
#   property_plant_and_equipment: 82_286_000_000,
#   goodwill: 14_207_000_000,
#   intangible_assets: 936_000_000,
#   other_assets: 10_173_000_000,
#   total_assets: 225_248_000_000,
#   accounts_payable: 70_161_000_000,
#   accrued_expenses: 16_729_000_000,
#   short_term_debt: 0,
#   current_portion_of_long_term_debt: 0,
#   other_current_liabilities: 13_929_000_000,
#   total_current_liabilities: 100_119_000_000,
#   long_term_debt: 31_778_000_000,
#   other_liabilities: 31_877_000_000,
#   total_liabilities: 152_505_000_000,
#   common_stock: 550_000,
#   retained_earnings: 71_283_000_000,
#   accumulated_other_comprehensive_income: -2_167_000_000,
#   total_stockholders_equity: 72_592_000_000,
#   total_liabilities_and_stockholders_equity: 225_248_000_000
# )

# balance_sheet2 = BalanceSheet.create(
#   quote_id: aapl.id,
#   fiscal_year: 2019,
#   fiscal_quarter: 4,
#   cash_and_cash_equivalents: 36_081_000_000,
#   short_term_investments: 11_963_000_000,
#   net_receivables: 15_462_000_000,
#   inventory: 14_954_000_000,
#   total_current_assets: 78_437_000_000,
#   long_term_investments: 19_784_000_000,
#   property_plant_and_equipment: 52_496_000_000,
#   goodwill: 13_715_000_000,
#   intangible_assets: 620_000_000,
#   other_assets: 8_314_000_000,
#   total_assets: 162_648_000_000,
#   accounts_payable: 56_417_000_000,
#   accrued_expenses: 23_816_000_000,
#   short_term_debt: 0,
#   current_portion_of_long_term_debt: 0,
#   other_current_liabilities: 11_594_000_000,
#   total_current_liabilities: 91_827_000_000,
#   long_term_debt: 23_194_000_000,
#   other_liabilities: 14_688_000_000,
#   total_liabilities: 129_931_000_000,
#   common_stock: 526_000,
#   retained_earnings: 57_493_000_000,
#   accumulated_other_comprehensive_income: -2_245_000_000,
#   total_stockholders_equity: 32_659_000_000,
#   total_liabilities_and_stockholders_equity: 162_648_000_000
# )

dividend1 = aapl.dividends.create(
  amount: 5.0,
  payment_date: Date.today,
  ex_dividend_date: Date.today - 1.month,
  record_date: Date.today - 1.week
)

dividend2 = amzn.dividends.create(
  amount: 2.5,
  payment_date: Date.today + 1.month,
  ex_dividend_date: Date.today + 1.week,
  record_date: Date.today - 1.month
)

# Seed events for a company

# Announcements
announcement1 = aapl.events.create(name: 'Apple to host Q4 2022 earnings call', event_type: 'Announcement',
                                   date: '2022-10-15', description: 'Apple will announce its fourth quarter earnings on October 27, 2022')
announcement2 = aapl.events.create(name: 'Apple announces new product launch event', event_type: 'Announcement',
                                   date: '2022-11-01', description: 'Apple will launch its new line of MacBooks and iPads on November 10, 2022')

# Corporate Actions
ca1 = aapl.events.create(name: 'Apple splits stock 4-for-1', event_type: 'Corporate Action', date: '2020-08-31',
                         description: 'Apple announced a 4-for-1 stock split, effective August 31, 2020')
ca2 = aapl.events.create(name: 'Apple announces $100 billion share buyback program', event_type: 'Corporate Action',
                         date: '2021-04-28', description: 'Apple announced a $100 billion share buyback program and increased its dividend by 7%')

# Dividend Announcements
dividend1 = aapl.events.create(name: 'Apple announces dividend increase', event_type: 'Dividend Announcement',
                               date: '2022-03-01', description: 'Apple announced a 10% increase in its dividend payout')
dividend2 = aapl.events.create(name: 'Apple declares dividend', event_type: 'Dividend Announcement',
                               date: '2021-11-01', description: 'Apple declared a quarterly dividend of $0.22 per share')

puts "Events seeded for #{aapl.name}"

# Seeds for shareholding patterns

# pattern1 = aapl.shareholding_patterns.create(
#   date: Date.today - 1.month,
#   promoter_holding: 60.0,
#   public_holding: 40.0,
#   institutions_holding: 20.0,
#   non_institutions_holding: 20.0
# )

# pattern2 = amzn.shareholding_patterns.create(
#   date: Date.today - 2.months,
#   promoter_holding: 70.0,
#   public_holding: 30.0,
#   institutions_holding: 15.0,
#   non_institutions_holding: 15.0
# )

# Create users
user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')

# Create bookmarks
user1.bookmarks.create(quote: aapl)
user1.bookmarks.create(quote: jpm)
user2.bookmarks.create(quote: goog)

# Add quotes to portfolio
# portfolio.portfolio_quotes.create(quote: aapl)
# portfolio.portfolio_quotes.create(quote: jpm)

# Create quote prices
QuotePrice.create(quote: aapl, date: Date.today - 1, price: 125.50)
QuotePrice.create(quote: aapl, date: Date.today - 2, price: 120.75)
QuotePrice.create(quote: aapl, date: Date.today - 3, price: 118.00)
QuotePrice.create(quote: jpm, date: Date.today - 1, price: 105.25)
QuotePrice.create(quote: jpm, date: Date.today - 2, price: 102.50)
QuotePrice.create(quote: jpm, date: Date.today - 3, price: 100.00)

# Seed data for MutualFund model
fund1 = MutualFund.create(name: 'Fidelity Contrafund', ticker: 'FCNTX', expense_ratio: 0.86, net_assets: 153.2)
fund2 = MutualFund.create(name: 'Vanguard 500 Index Fund', ticker: 'VFIAX', expense_ratio: 0.04, net_assets: 772.1)

# Seed data for ETF model
etf1 = Etf.create(name: 'SPDR S&P 500 ETF', ticker: 'SPY', expense_ratio: 0.09, net_assets: 394.1)
etf2 = Etf.create(name: 'Invesco QQQ Trust', ticker: 'QQQ', expense_ratio: 0.20, net_assets: 198.8)

# create a sample popular investor with the portfolio
warren_buffett = PopularInvestor.create(name: 'Warren Buffett')

# Create a portfolio
# portfolio = Portfolio.create(popular_investor: warren_buffett)

# add the quotes to the portfolio
# portfolio.portfolio_quotes.create(quote: aapl)
# portfolio.portfolio_quotes.create(quote: amzn)

# # add some activities to the portfolio
# portfolio.activities.create(action: "add", quote: quote1)
# portfolio.activities.create(action: "add", quote: quote2)
# portfolio.activities.create(action: "remove", quote: quote1)
