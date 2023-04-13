# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

namespace :scrap_web do
  desc 'Fetch and save stock information'
  task :get_stock_data, [:ticker] => [:environment] do |_, args|
    ticker = args[:ticker] || 'AAPL'

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

    @json = json
    @quote  = create_or_update_quote(ticker)

    create_balance_sheets

    create_cash_flows

    create_income_statements

    # historical = json['historical']
    # historicalyears = json['historicalyears']
    # historicalyearsavg = json['historicalyearsavg']
    # earningscalls = json['earningscalls']

    # outlook = json['outlook'][0]
    # profile = outlook['profile']
    # ratios = outlook['ratios']
    # financialsAnnual = outlook['financialsAnnual']
    # financialsQuarter = outlook['financialsQuarter']

    create_monthly_price_data
    create_yearly_price_data

    create_split_history
    update_ratios
    create_dividends
    update_financials
  end

  def create_split_history
    splitsHistory = @json['outlook'][0]['splitsHistory']

    splitsHistory.each do |data|
      resource = SplitHistory.new(quote: @quote)
      data = transform(data, ['label'])
      resource.assign_attributes(data)
      resource.save!
    end
  end

  def create_monthly_price_data
    historical = @json['historical']
    historical.each do |data|
      resource = MonthlyPrice.new(quote: @quote)

      date = data['date'].split('/')
      data['month'] = date.last
      data['year'] = date.first
      data = transform(data, ['date'], { 'lastdayclose': 'last_day_close' })

      resource.assign_attributes(data)
      resource.save!
    end
  end

  def create_yearly_price_data
    historicalyears = @json['historicalyears']
    historicalyearsavg = @json['historicalyearsavg']

    historicalyears.each_with_index do |yearly_data, index|
      yearly_avg_data = historicalyearsavg[index]
      if yearly_avg_data['date'] != yearly_data['date']
        print '~~~~~~DATE MISMATCH~~~~~~~~'
        return
      end

      yearly_data.merge!(yearly_avg_data)
      resource = YearlyPrice.new(quote: @quote)
      yearly_data = transform(yearly_data, [], { 'date': 'year' })

      resource.assign_attributes(yearly_data)
      resource.save!
    end
  end

  def create_cash_flows
    # cash flow quaterly
    cfq = @json['cfq']
    cfq.each do |bs|
      create_cash_flow(bs)
    end

    # CASH FLOW STATEMENT, yearly
    cfy = @json['cfy']
    cfy.each do |bs|
      create_cash_flow(bs)
    end

    puts '-----Cash Flow DATA Created------'
  end

  def create_income_statements
    # income statement quaterly
    isq = @json['isq']
    isq.each do |bs|
      create_income_statement(bs)
    end

    # income statement yearly
    isy = @json['isy']
    isy.each do |bs|
      create_income_statement(bs)
    end
  end

  def create_balance_sheets
    # balance sheet quaterly
    bsq = @json['bsq']
    # Create balance sheets
    bsq.each do |bs|
      create_balance_sheet(bs)
    end

    # BALANCE SHEET, annual
    bsy = @json['bsy']

    # Create balance sheets
    bsy.each do |bs|
      create_balance_sheet(bs)
    end

    puts '-----Balance Sheet DATA Created------'
  end

  def create_dividends
    dividends = @json['outlook'][0]['stockDividend']

    dividends.each do |data|
      resource = Dividend.new(quote: @quote)
      data = transform(data, %w[label adjDividend], { 'dividend': 'amount' })
      resource.assign_attributes(data)
      resource.save!
    end
    puts '-----Dividends Created------'
  end

  def update_ratios
    ratios = @json['outlook'][0]['ratios'][0]
    resource = Ratio.new(quote: @quote)
    data = transform(ratios, [],
                     { 'dividend_yiel_ttm': 'dividend_yield_ttm', 'dividend_yiel_percentage_ttm': 'dividend_yield_percentage_ttm' })
    resource.assign_attributes(data)
    resource.save!
    puts '-----RATIO Created------'
  end

  def update_financials
    outlook = @json['outlook'][0]
    financialsAnnual = outlook['financialsAnnual']
    financialsQuarter = outlook['financialsQuarter']

    create_financial_data(financialsAnnual)
    create_financial_data(financialsQuarter)

    puts '-----FINANCIAL DATA Created------'
  end

  def create_financial_data(data)
    income_data = data['income']
    balance_data = data['balance']
    cash_data = data['cash']

    income_data.each_with_index do |income, index|
      balance = balance_data[index]
      cash = cash_data[index]

      all = income.merge(cash, balance)

      record = FinancialStatement.new(quote: @quote)
      record.assign_attributes(transform_and_skip_fields(all))
      record.save!
    end
  end

  def create_or_update_quote(ticker)
    profile = @json['outlook'][0]['profile']

    profile = transform(profile)
    exchange = create_exchange_if_needed(profile)
    sector, industry = create_industry_n_sector(profile)

    quote = Quote.find_by(ticker:) || Quote.new(ticker:)

    quote.exchange = exchange if quote.exchange.blank?
    quote.sector = sector if quote.sector.blank?
    quote.industry = industry if quote.industry.blank?

    skip_keys = %w[symbol range changes currency exchange exchange_short_name default_image is_adr
                   is_actively_trading industry sector]

    change_keys = { 'mkt_cap': 'market_cap', 'vol_avg': 'volume', 'company_name': 'name' }
    d = transform(profile, skip_keys, change_keys)

    quote.assign_attributes(d)
    quote.save!

    puts '-----Quote Created/updated------'
    puts 'Name: #{quote.name}'
    quote
  end

  def create_exchange_if_needed(profile)
    name = profile['exchange_short_name']
    full_name = profile['exchange']
    currency = profile['currency']

    Exchange.find_by(name:) || Exchange.create!(name:, full_name:, currency:)
  end

  def create_industry_n_sector(profile)
    industry_name = profile['industry']
    sector_name = profile['sector']

    sector = Sector.find_or_create_by!(name: sector_name)
    industry = sector.industries.find_or_create_by!(name: industry_name)
    [sector, industry]
  end

  def rename_attr(data, atrs)
    new_data = {}
    atrs.each { |old_k, new_k| data[new_k] = data.delete(old_k.to_s) }
    data
  end

  SKIP_FIELDS = %w[reported_currency symbol].freeze

  def create_balance_sheet(bs)
    record = BalanceSheet.new(quote: @quote)
    bs = transform_and_skip_fields(bs)
    record.assign_attributes(bs)
    record.save!
  end

  def create_cash_flow(bs)
    record = CashFlow.new(quote: @quote)
    bs = transform_and_skip_fields(bs)
    record.assign_attributes(bs)
    record.save!
  end

  def create_income_statement(bs)
    record = IncomeStatement.new(quote: @quote)
    record.assign_attributes(transform_and_skip_fields(bs))
    record.save!
  end

  def transform(data, skip_keys = [], change_keys = {})
    bs_n = {}
    data.each do |k, v|
      key = k.to_s.underscore
      next if skip_keys.include? k.to_s
      next if skip_keys.include? key

      change_keys = change_keys.with_indifferent_access
      key = change_keys[key] if change_keys[key]

      bs_n[key] = v
    end

    bs_n
  end

  def transform_and_skip_fields(data)
    transform(data).except!(*SKIP_FIELDS)
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

  def migration_format(data, append_cents: true, type: 'integer')
    str = ''
    transform(data).each do |field, _v|
      field_type = type

      is_ratio = field.to_s.downcase.include? 'ratio'
      field_type = 'float' if is_ratio

      append = append_cents && !is_ratio ? '_cents' : ''
      str += "t.#{field_type} :#{field}#{append} \n"
    end
    puts str
    str
  end

  def monetize_format(data)
    monetize = 'monetize '

    transform(data).each do |field, _v|
      is_ratio = field.to_s.downcase.include? 'ratio'
      next if is_ratio

      monetize += ":#{field}_cents,\n"
    end
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
