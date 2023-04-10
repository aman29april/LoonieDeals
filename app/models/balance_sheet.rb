# frozen_string_literal: true

class BalanceSheet < ApplicationRecord
  validates :fiscal_period, presence: true
  validates :total_assets, presence: true, numericality: true
  validates :total_liabilities, presence: true, numericality: true
  validates :total_equity, presence: true, numericality: true
  validates :quote_id, presence: true

  belongs_to :quote
end
