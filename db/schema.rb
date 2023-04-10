# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_410_201_327) do
  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'author_type'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'activities', force: :cascade do |t|
    t.integer 'portfolio_id', null: false
    t.integer 'action'
    t.integer 'quote_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['portfolio_id'], name: 'index_activities_on_portfolio_id'
    t.index ['quote_id'], name: 'index_activities_on_quote_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'balance_sheets', force: :cascade do |t|
    t.integer 'quote_id', null: false
    t.date 'date'
    t.integer 'fiscal_year'
    t.integer 'fiscal_quarter'
    t.string 'fiscal_period'
    t.integer 'cash_and_cash_equivalents'
    t.integer 'short_term_investments'
    t.integer 'net_receivables'
    t.integer 'inventory'
    t.integer 'other_current_assets'
    t.integer 'total_current_assets'
    t.integer 'property_plant_and_equipment'
    t.integer 'long_term_investments'
    t.integer 'goodwill'
    t.integer 'intangible_assets'
    t.integer 'accumulated_amortization'
    t.integer 'other_assets'
    t.integer 'total_assets'
    t.integer 'accounts_payable'
    t.integer 'short_term_debt'
    t.integer 'taxes_payable'
    t.integer 'accrued_liabilities'
    t.integer 'accrued_expenses'
    t.integer 'other_current_liabilities'
    t.integer 'total_current_liabilities'
    t.integer 'long_term_debt'
    t.integer 'current_portion_of_long_term_debt'
    t.integer 'deferred_revenue'
    t.integer 'deferred_income_tax'
    t.integer 'other_liabilities'
    t.integer 'minority_interest'
    t.integer 'total_liabilities'
    t.integer 'preferred_equity'
    t.integer 'total_liabilities_and_stockholders_equity'
    t.integer 'common_stock'
    t.integer 'retained_earnings'
    t.integer 'accumulated_other_comprehensive_income'
    t.integer 'treasury_stock'
    t.integer 'total_stockholders_equity'
    t.integer 'total_equity'
    t.integer 'net_tangible_assets'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_balance_sheets_on_quote_id'
  end

  create_table 'bookmarks', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'quote_id', null: false
    t.string 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_bookmarks_on_quote_id'
    t.index ['user_id'], name: 'index_bookmarks_on_user_id'
  end

  create_table 'cash_flows', force: :cascade do |t|
    t.integer 'fiscal_year'
    t.integer 'fiscal_quarter'
    t.string 'fiscal_period'
    t.decimal 'cash_from_operating_activities'
    t.decimal 'net_income'
    t.decimal 'depreciation_and_amortization'
    t.decimal 'deferred_income_taxes'
    t.decimal 'stock_based_compensation'
    t.decimal 'change_in_working_capital'
    t.decimal 'accounts_receivable'
    t.decimal 'inventory'
    t.decimal 'accounts_payable'
    t.decimal 'other_working_capital'
    t.decimal 'net_cash_from_operating_activities'
    t.decimal 'cash_from_investing_activities'
    t.decimal 'capital_expenditures'
    t.decimal 'acquisitions_and_disposals'
    t.decimal 'investment_purchases_and_sales'
    t.decimal 'net_cash_from_investing_activities'
    t.decimal 'cash_from_financing_activities'
    t.decimal 'net_change_in_debt'
    t.decimal 'issue_of_capital_stock'
    t.decimal 'repurchase_of_capital_stock'
    t.decimal 'dividend_payments'
    t.decimal 'other_financing_activities'
    t.decimal 'net_cash_from_financing_activities'
    t.decimal 'effect_of_exchange_rate_changes'
    t.decimal 'change_in_cash_and_cash_equivalents'
    t.string 'report_type'
    t.integer 'quote_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_cash_flows_on_quote_id'
  end

  create_table 'company_peers', force: :cascade do |t|
    t.integer 'company_id', null: false
    t.integer 'peer_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_company_peers_on_company_id'
    t.index ['peer_id'], name: 'index_company_peers_on_peer_id'
  end

  create_table 'dividends', force: :cascade do |t|
    t.integer 'quote_id', null: false
    t.date 'ex_dividend_date'
    t.date 'dividend_date'
    t.date 'record_date'
    t.date 'payment_date'
    t.float 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_dividends_on_quote_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.string 'event_type'
    t.date 'date'
    t.text 'description'
    t.integer 'quote_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_events_on_quote_id'
  end

  create_table 'exchanges', force: :cascade do |t|
    t.string 'name'
    t.string 'symbol'
    t.string 'country'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'peers', force: :cascade do |t|
    t.integer 'company_id', null: false
    t.integer 'peer_company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_peers_on_company_id'
    t.index ['peer_company_id'], name: 'index_peers_on_peer_company_id'
  end

  create_table 'popular_investors', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
    t.text 'bio'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'portfolios', force: :cascade do |t|
    t.integer 'popular_investors_id', null: false
    t.integer 'number_of_shares'
    t.integer 'year'
    t.integer 'quarter'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['popular_investors_id'], name: 'index_portfolios_on_popular_investors_id'
  end

  create_table 'profit_and_loss_statements', force: :cascade do |t|
    t.integer 'quote_id', null: false
    t.date 'date'
    t.integer 'fiscal_year'
    t.integer 'fiscal_quarter'
    t.string 'fiscal_period'
    t.integer 'revenue'
    t.integer 'total_revenue'
    t.integer 'cost_of_revenue'
    t.integer 'gross_profit'
    t.integer 'research_and_development'
    t.integer 'selling_general_and_admin'
    t.integer 'operating_expenses'
    t.integer 'operating_income'
    t.integer 'interest_expense'
    t.integer 'other_income_expense'
    t.integer 'income_before_tax'
    t.integer 'income_tax_expense'
    t.integer 'minority_interest'
    t.integer 'net_income'
    t.integer 'preferred_dividends'
    t.integer 'earnings_available_for_common_stockholders'
    t.float 'basic_eps'
    t.float 'diluted_eps'
    t.integer 'basic_shares_outstanding'
    t.integer 'diluted_shares_outstanding'
    t.float 'dividends_per_share'
    t.integer 'gross_dividends'
    t.integer 'net_income_from_continuing_operations'
    t.integer 'net_income_from_discontinued_operations'
    t.integer 'net_income_from_total_operations'
    t.integer 'normalized_income_before_taxes'
    t.integer 'normalized_income_after_taxes'
    t.integer 'normalized_income_avail_to_common'
    t.float 'basic_normalized_eps'
    t.float 'diluted_normalized_eps'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_profit_and_loss_statements_on_quote_id'
  end

  create_table 'quote_prices', force: :cascade do |t|
    t.decimal 'open'
    t.decimal 'high'
    t.decimal 'low'
    t.decimal 'close'
    t.float 'price'
    t.integer 'volume'
    t.date 'date'
    t.integer 'quote_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_quote_prices_on_quote_id'
  end

  create_table 'quotes', force: :cascade do |t|
    t.string 'name'
    t.string 'ticker'
    t.string 'sector'
    t.string 'industry'
    t.integer 'market_cap'
    t.integer 'employees'
    t.text 'description'
    t.string 'website'
    t.string 'phone'
    t.string 'address'
    t.string 'city'
    t.string 'state'
    t.string 'zip'
    t.string 'ceo'
    t.date 'founded'
    t.string 'country'
    t.string 'fund_family'
    t.decimal 'expense_ratio', default: '0.0'
    t.decimal 'beta'
    t.decimal 'dividend_yield', default: '0.0'
    t.decimal 'price_to_earnings_ratio'
    t.decimal 'earnings_per_share'
    t.decimal 'price_to_book_ratio'
    t.float 'net_assets'
    t.integer 'exchange_id', null: false
    t.integer 'sector_id', null: false
    t.string 'type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['exchange_id'], name: 'index_quotes_on_exchange_id'
    t.index ['sector_id'], name: 'index_quotes_on_sector_id'
  end

  create_table 'ratios', force: :cascade do |t|
    t.string 'name'
    t.decimal 'value'
    t.integer 'year'
    t.integer 'company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_ratios_on_company_id'
  end

  create_table 'sectors', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'shareholding_patterns', force: :cascade do |t|
    t.integer 'shareholding_period_id', null: false
    t.string 'shareholder_name'
    t.float 'shareholding_percentage'
    t.float 'promoter_holding'
    t.float 'public_holding'
    t.float 'non_institutions_holding'
    t.float 'institutions_holding'
    t.date 'date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['shareholding_period_id'], name: 'index_shareholding_patterns_on_shareholding_period_id'
  end

  create_table 'shareholding_periods', force: :cascade do |t|
    t.integer 'quote_id', null: false
    t.string 'period_type'
    t.date 'start_date'
    t.date 'end_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['quote_id'], name: 'index_shareholding_periods_on_quote_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'activities', 'portfolios'
  add_foreign_key 'activities', 'quotes'
  add_foreign_key 'balance_sheets', 'quotes'
  add_foreign_key 'bookmarks', 'quotes'
  add_foreign_key 'bookmarks', 'users'
  add_foreign_key 'cash_flows', 'quotes'
  add_foreign_key 'company_peers', 'companies'
  add_foreign_key 'company_peers', 'peers'
  add_foreign_key 'dividends', 'quotes'
  add_foreign_key 'events', 'quotes'
  add_foreign_key 'peers', 'companies'
  add_foreign_key 'peers', 'peer_companies'
  add_foreign_key 'portfolios', 'popular_investors', column: 'popular_investors_id'
  add_foreign_key 'profit_and_loss_statements', 'quotes'
  add_foreign_key 'quote_prices', 'quotes'
  add_foreign_key 'quotes', 'exchanges'
  add_foreign_key 'quotes', 'sectors'
  add_foreign_key 'ratios', 'companies'
  add_foreign_key 'shareholding_patterns', 'shareholding_periods'
  add_foreign_key 'shareholding_periods', 'quotes'
end
