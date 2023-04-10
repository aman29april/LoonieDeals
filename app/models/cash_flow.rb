# frozen_string_literal: true

class CashFlow < ApplicationRecord
  validates :fiscal_period, presence: true
  validates :cash_from_operating_activities, presence: true, numericality: true
  validates :cash_from_investing_activities, presence: true, numericality: true
  validates :cash_from_financing_activities, presence: true, numericality: true
  # validates :effect_of_exchange_rate_changes, presence: true, numericality: true
  # validates :change_in_cash_and_cash_equivalents, presence: true, numericality: true
  validates :quote_id, presence: true

  belongs_to :quote
end
