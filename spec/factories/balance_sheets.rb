# frozen_string_literal: true

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
