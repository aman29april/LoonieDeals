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
require 'rails_helper'

RSpec.describe BalanceSheet, type: :model do
  subject { FactoryBot.create(:balance_sheet) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:total_assets) }
    it { should validate_numericality_of(:total_assets) }
    it { should validate_presence_of(:total_liabilities) }
    it { should validate_numericality_of(:total_liabilities) }
    it { should validate_presence_of(:total_equity) }
    it { should validate_numericality_of(:total_equity) }
    it { should validate_presence_of(:company_id) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
