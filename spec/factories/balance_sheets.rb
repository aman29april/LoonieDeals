# frozen_string_literal: true

# == Schema Information
#
# Table name: balance_sheets
#
#  id                                                :integer          not null, primary key
#  accepted_date                                     :datetime
#  account_payables_cents                            :integer
#  accumulated_other_comprehensive_income_loss_cents :integer
#  calendar_year                                     :integer
#  capital_lease_obligations_cents                   :integer
#  cash_and_cash_equivalents_cents                   :integer
#  cash_and_short_term_investments_cents             :integer
#  cik                                               :string
#  common_stock_cents                                :integer
#  currency                                          :string           default("USD"), not null
#  date                                              :date
#  deferred_revenue_cents                            :integer
#  deferred_revenue_non_current_cents                :integer
#  deferred_tax_liabilities_non_current_cents        :integer
#  filling_date                                      :datetime
#  final_link                                        :string
#  goodwill_and_intangible_assets_cents              :integer
#  goodwill_cents                                    :integer
#  intangible_assets_cents                           :integer
#  inventory_cents                                   :integer
#  link                                              :string
#  long_term_debt_cents                              :integer
#  long_term_investments_cents                       :integer
#  minority_interest_cents                           :integer
#  net_debt_cents                                    :integer
#  net_receivables_cents                             :integer
#  other_assets_cents                                :integer
#  other_current_assets_cents                        :integer
#  other_current_liabilities_cents                   :integer
#  other_liabilities_cents                           :integer
#  other_non_current_assets_cents                    :integer
#  other_non_current_liabilities_cents               :integer
#  othertotal_stockholders_equity_cents              :integer
#  period                                            :string
#  preferred_stock_cents                             :integer
#  property_plant_equipment_net_cents                :integer
#  retained_earnings_cents                           :integer
#  short_term_debt_cents                             :integer
#  short_term_investments_cents                      :integer
#  tax_assets_cents                                  :integer
#  tax_payables_cents                                :integer
#  total_assets_cents                                :integer
#  total_current_assets_cents                        :integer
#  total_current_liabilities_cents                   :integer
#  total_debt_cents                                  :integer
#  total_equity_cents                                :integer
#  total_investments_cents                           :integer
#  total_liabilities_and_stockholders_equity_cents   :integer
#  total_liabilities_and_total_equity_cents          :integer
#  total_liabilities_cents                           :integer
#  total_non_current_assets_cents                    :integer
#  total_non_current_liabilities_cents               :integer
#  total_stockholders_equity_cents                   :integer
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#  quote_id                                          :integer          not null
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
