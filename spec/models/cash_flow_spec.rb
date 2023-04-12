# frozen_string_literal: true

# == Schema Information
#
# Table name: cash_flows
#
#  id                                                   :integer          not null, primary key
#  accepted_date                                        :datetime         default(NULL), not null
#  accounts_payables_cents                              :integer
#  accounts_receivables_cents                           :integer
#  acquisitions_net_cents                               :integer
#  calendar_year                                        :integer          not null
#  capital_expenditure_cents                            :integer
#  cash_at_beginning_of_period_cents                    :integer
#  cash_at_end_of_period_cents                          :integer
#  change_in_working_capital_cents                      :integer
#  cik                                                  :string
#  common_stock_issued_cents                            :integer
#  common_stock_repurchased_cents                       :integer
#  currency                                             :string           default("USD"), not null
#  date                                                 :date
#  debt_repayment_cents                                 :integer
#  deferred_income_tax_cents                            :integer
#  depreciation_and_amortization_cents                  :integer
#  dividends_paid_cents                                 :integer
#  effect_of_forex_changes_on_cash_cents                :integer
#  filling_date                                         :datetime         default(NULL), not null
#  final_link                                           :string
#  free_cash_flow_cents                                 :integer
#  inventory_cents                                      :integer
#  investments_in_property_plant_and_equipment_cents    :integer
#  link                                                 :string
#  net_cash_provided_by_operating_activities_cents      :integer
#  net_cash_used_for_investing_activites_cents          :integer
#  net_cash_used_provided_by_financing_activities_cents :integer
#  net_change_in_cash_cents                             :integer
#  net_income_cents                                     :integer
#  operating_cash_flow_cents                            :integer
#  other_financing_activites_cents                      :integer
#  other_investing_activites_cents                      :integer
#  other_non_cash_items_cents                           :integer
#  other_working_capital_cents                          :integer
#  period                                               :string
#  purchases_of_investments_cents                       :integer
#  sales_maturities_of_investments_cents                :integer
#  stock_based_compensation_cents                       :integer
#  created_at                                           :datetime         not null
#  updated_at                                           :datetime         not null
#  quote_id                                             :integer          not null
#
# Indexes
#
#  index_cash_flows_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
require 'rails_helper'

RSpec.describe CashFlow, type: :model do
  subject { FactoryBot.create(:cash_flow) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:cash_from_operating_activities) }
  end
end
