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
require 'test_helper'

class BalanceSheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
