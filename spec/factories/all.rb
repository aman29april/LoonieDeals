# frozen_string_literal: true

FactoryBot.define do
  #   factory :exchange do
  #     name { 'NYSE' }
  #   end

  #   factory :company do
  #     name { 'Apple Inc.' }
  #     exchange
  #   end

  #   factory :balance_sheet do
  #     company
  #     fiscal_period { Date.today }
  #     cash_and_cash_equivalents { 100_000 }
  #     short_term_investments { 50_000 }
  #     net_receivables { 200_000 }
  #     inventory { 150_000 }
  #     other_current_assets { 50_000 }
  #     total_current_assets { 550_000 }
  #     long_term_investments { 250_000 }
  #     property_plant_and_equipment { 1_000_000 }
  #     intangible_assets { 500_000 }
  #     other_assets { 100_000 }
  #     total_assets { 2_000_000 }
  #     accounts_payable { 150_000 }
  #     short_term_debt { 100_000 }
  #     other_current_liabilities { 75_000 }
  #     total_current_liabilities { 325_000 }
  #     long_term_debt { 500_000 }
  #     other_liabilities { 125_000 }
  #     total_liabilities { 950_000 }
  #     common_stock { 100_000 }
  #     retained_earnings { 850_000 }
  #     total_stockholders_equity { 950_000 }
  #   end

  #   factory :profit_and_loss_statement do
  #     company
  #     fiscal_period { Date.today }
  #     revenue { 1_000_000 }
  #     cost_of_revenue { 600_000 }
  #     gross_profit { 400_000 }
  #     operating_expenses { 200_000 }
  #     operating_income { 200_000 }
  #     net_income { 150_000 }
  #   end

  #   factory :cash_flow do
  #     company
  #     fiscal_period { Date.today }
  #     net_income { 100_000 }
  #     depreciation { 20_000 }
  #     changes_in_receivables { 5000 }
  #     changes_in_inventories { 2000 }
  #     changes_in_payables { 3000 }
  #     changes_in_working_capital { 10_000 }
  #     cash_from_operating_activities { 40_000 }
  #     capital_expenditures { 10_000 }
  #     free_cash_flow { 30_000 }
  #     dividends_paid { 5000 }
  #   end
end
