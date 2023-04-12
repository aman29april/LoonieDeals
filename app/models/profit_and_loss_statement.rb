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
#  index_profit_and_loss_statements_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class ProfitAndLossStatement < ApplicationRecord
  validates :fiscal_year, presence: true
  validates :total_revenue, presence: true, numericality: true
  validates :cost_of_revenue, presence: true, numericality: true
  validates :gross_profit, presence: true, numericality: true
  validates :operating_expenses, presence: true, numericality: true
  validates :operating_income, presence: true, numericality: true
  validates :net_income, presence: true, numericality: true
  validates :quote_id, presence: true
  belongs_to :quote
end
