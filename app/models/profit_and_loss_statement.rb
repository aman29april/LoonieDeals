# frozen_string_literal: true

class ProfitAndLossStatement < ApplicationRecord
  validates :fiscal_period, presence: true
  validates :total_revenue, presence: true, numericality: true
  validates :cost_of_revenue, presence: true, numericality: true
  validates :gross_profit, presence: true, numericality: true
  validates :operating_expenses, presence: true, numericality: true
  validates :operating_income, presence: true, numericality: true
  validates :net_income, presence: true, numericality: true
  validates :quote_id, presence: true
  belongs_to :quote
end
