# frozen_string_literal: true

# == Schema Information
#
# Table name: balance_sheets
#
#  id                                        :integer          not null, primary key
#  accounts_payable                          :integer
#  accrued_expenses                          :integer
#  accrued_liabilities                       :integer
#  accumulated_amortization                  :integer
#  accumulated_other_comprehensive_income    :integer
#  cash_and_cash_equivalents                 :integer
#  common_stock                              :integer
#  current_portion_of_long_term_debt         :integer
#  date                                      :date
#  deferred_income_tax                       :integer
#  deferred_revenue                          :integer
#  fiscal_period                             :string
#  fiscal_quarter                            :integer
#  fiscal_year                               :integer
#  goodwill                                  :integer
#  intangible_assets                         :integer
#  inventory                                 :integer
#  long_term_debt                            :integer
#  long_term_investments                     :integer
#  minority_interest                         :integer
#  net_receivables                           :integer
#  net_tangible_assets                       :integer
#  other_assets                              :integer
#  other_current_assets                      :integer
#  other_current_liabilities                 :integer
#  other_liabilities                         :integer
#  preferred_equity                          :integer
#  property_plant_and_equipment              :integer
#  retained_earnings                         :integer
#  short_term_debt                           :integer
#  short_term_investments                    :integer
#  taxes_payable                             :integer
#  total_assets                              :integer
#  total_current_assets                      :integer
#  total_current_liabilities                 :integer
#  total_equity                              :integer
#  total_liabilities                         :integer
#  total_liabilities_and_stockholders_equity :integer
#  total_stockholders_equity                 :integer
#  treasury_stock                            :integer
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  quote_id                                  :integer          not null
#
# Indexes
#
#  index_balance_sheets_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :balance_sheet do
    fund_family { 'MyString' }

    period { Date.today.beginning_of_quarter }
    cash_and_cash_equivalents { 100_000 }
    short_term_investments { 50_000 }
    accounts_receivable { 80_000 }
    inventory { 20_000 }
    prepaid_expenses { 5_000 }
    other_current_assets { 10_000 }
    total_current_assets { 265_000 }

    property_plant_and_equipment { 500_000 }
    accumulated_depreciation { 200_000 }
    goodwill { 100_000 }
    intangible_assets { 50_000 }
    other_non_current_assets { 20_000 }
    total_non_current_assets { 470_000 }

    total_assets { 735_000 }

    accounts_payable { 50_000 }
    accrued_expenses { 20_000 }
    short_term_debt { 30_000 }
    current_portion_of_long_term_debt { 10_000 }
    other_current_liabilities { 5_000 }
    total_current_liabilities { 115_000 }

    long_term_debt { 200_000 }
    deferred_income_tax { 40_000 }
    other_non_current_liabilities { 20_000 }
    total_non_current_liabilities { 260_000 }

    total_liabilities { 375_000 }

    preferred_stock { 0 }
    common_stock { 50_000 }
    additional_paid_in_capital { 150_000 }
    retained_earnings { 150_000 }
    accumulated_other_comprehensive_income { 10_000 }
    total_equity { 360_000 }

    total_liabilities_and_equity { 735_000 }
  end
end
