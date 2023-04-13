# frozen_string_literal: true

# == Schema Information
#
# Table name: profit_and_loss_statements
#
#  id                                         :integer          not null, primary key
#  basic_eps                                  :float
#  basic_normalized_eps                       :float
#  basic_shares_outstanding                   :integer
#  cost_of_revenue                            :integer
#  date                                       :date
#  diluted_eps                                :float
#  diluted_normalized_eps                     :float
#  diluted_shares_outstanding                 :integer
#  dividends_per_share                        :float
#  earnings_available_for_common_stockholders :integer
#  fiscal_quarter                             :integer
#  fiscal_year                                :integer
#  gross_dividends                            :integer
#  gross_profit                               :integer
#  income_before_tax                          :integer
#  income_tax_expense                         :integer
#  interest_expense                           :integer
#  minority_interest                          :integer
#  net_income                                 :integer
#  net_income_from_continuing_operations      :integer
#  net_income_from_discontinued_operations    :integer
#  net_income_from_total_operations           :integer
#  normalized_income_after_taxes              :integer
#  normalized_income_avail_to_common          :integer
#  normalized_income_before_taxes             :integer
#  operating_expenses                         :integer
#  operating_income                           :integer
#  other_income_expense                       :integer
#  preferred_dividends                        :integer
#  research_and_development                   :integer
#  revenue                                    :integer
#  selling_general_and_admin                  :integer
#  total_revenue                              :integer
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  quote_id                                   :integer          not null
#
# Indexes
#
#  index_profit_and_loss_statements_on_quote_id           (quote_id)
#  index_profit_and_loss_statements_on_quote_period_year  ("quote_id", "period", "calendar_year") UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
require 'rails_helper'

RSpec.describe ProfitAndLossStatement, type: :model do
  subject { FactoryBot.create(:profit_and_loss_statement) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:revenue) }
    it { should validate_numericality_of(:revenue) }
    it { should validate_presence_of(:cost_of_revenue) }
    it { should validate_numericality_of(:cost_of_revenue) }
    it { should validate_presence_of(:gross_profit) }
    it { should validate_numericality_of(:gross_profit) }
    it { should validate_presence_of(:operating_expenses) }
    it { should validate_numericality_of(:operating_expenses) }
    it { should validate_presence_of(:operating_income) }
    it { should validate_numericality_of(:operating_income) }
    it { should validate_presence_of(:net_income) }
    it { should validate_numericality_of(:net_income) }
    it { should validate_presence_of(:company_id) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
