# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

namespace :scrap_web do
  desc 'TODO'
  task get_stock_data: :environment do
    ticker = 'AAPL'

    add_to_db(ticker)
  end

  def add_to_db(ticker)
    response = HTTParty.get("https://roic.ai/financials/#{ticker}")

    if response.code != 200
      puts "Error: #{response.code}"
      exit
    end

    document = Nokogiri::HTML4(response.body)

    data = document.xpath("//*[@id='__NEXT_DATA__']/text()")
    json = JSON.parse(data[0])
    json = json['props']['pageProps']['data']['data']

    # File.open("parsed.json", "w") { |f| f.write "#{json}" }

    # balance sheet quaterly
    bsq = json['bsq']
    # Create balance sheets
    bsq.each do |bs|
      create_balance_sheet(bs, ticker)
    end

    # BALANCE SHEET, annual
    bsy = json['bsy']

    # Create balance sheets
    bsy.each do |bs|
      create_balance_sheet(bs, ticker)
    end

    debugger
    # cash flow quaterly
    cfq = json['cfq']
    cfq.each do |bs|
      create_cash_flow(bs, ticker)
    end

    # CASH FLOW STATEMENT, yearly
    cfy = json['cfy']
    cfy.each do |bs|
      create_cash_flow(bs, ticker)
    end

    # income statement quaterly
    isq = json['isq']
    isq.each do |bs|
      create_income_statement(bs, ticker)
    end

    # income statement yearly
    isy = json['isy']
    isy.each do |bs|
      create_income_statement(bs, ticker)
    end

    historical = json['historical']
    historicalyears = json['historicalyears']
    historicalyearsavg = json['historicalyearsavg']
    earningscalls = json['earningscalls']

    outlook = json['outlook'][0]
    profile = outlook['profile']
    ratios = outlook['ratios']
    financialsAnnual = outlook['financialsAnnual']
    financialsQuarter = outlook['financialsQuarter']
  end

  SKIP_FIELDS = %w[reported_currency symbol].freeze

  def create_balance_sheet(bs, ticker)
    quote = Quote.find_by(ticker:)
    record = BalanceSheet.new(quote:)
    bs = transform_and_skip_fields(bs)
    record.assign_attributes(bs)
    record.save!
  end

  def create_cash_flow(bs, ticker)
    quote = Quote.find_by(ticker:)
    record = CashFlow.new(quote:)
    bs = transform_and_skip_fields(bs)
    record.assign_attributes(bs)
    record.save!
  end

  def create_income_statement(bs, ticker)
    quote = Quote.find_by(ticker:)
    record = IncomeStatement.new(quote:)
    record.assign_attributes(transform_and_skip_fields(bs))
    record.save!
  end

  def transform(data)
    bs_n = {}
    data.each { |k, v| bs_n[k.underscore] = v }
    bs_n
  end

  def transform_and_skip_fields(data)
    transform(data).except(*SKIP_FIELDS)
  end

  def seed_format(data)
    str = ''
    transform(data).each { |k, v| str += "#{k}: #{v},\n" }
    puts str
    str
  end

  def model_map_format(data)
    str = ''
    transform(data).each { |k, _v| str += "#{k}: {text: '#{k.titlecase}' },\n" }
    puts str
    str
  end

  def migration_format(data)
    str = ''
    transform(data).each { |field, _v| str += "t.integer :#{field}_cents \n" }
    puts str
    str
  end

  def monetize_format(data)
    monetize = 'monetize '
    transform(data).each { |field, _v| monetize += ":#{field},\n" }
    monetize += ' with_model_currency: :currency'
    puts monetize
    monetize
  end

  def format_seed(_data)
    str = ''
    isy.first.each { |k, v| str += "#{k.underscore}: #{v},\n" }
    puts str

    str = ''
    isy.first.each { |k, _v| str += "#{k.underscore}: {text: '#{k.titlecase}' },\n" }
    puts str

    fields = isy.first.keys.map { |s| "#{s.underscore}_cents" }.map(&:to_sym)
    str = ''
    fields.each { |field| str += "t.integer :#{field} \n" }
    puts str

    monetize = 'monetize '
    fields.each { |field| monetize += ":#{field},\n" }
    monetize += ' with_model_currency: :currency'
    puts monetize
  end
end
