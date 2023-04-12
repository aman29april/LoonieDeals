# frozen_string_literal: true

module FinancialStatementHelper
  extend ActiveSupport::Concern

  included do
    scope :by_year_n_quarter, -> { order(fiscal_year: :asc, fiscal_quarter: :asc) }

    def fiscal_period
      calendar_year
      # if period_cents.blank?

      # [fiscal_year, "Q#{fiscal_quarter}"].join(' ')
    end

    def to_row
      data = map.clone
      data.each do |key, hash|
        field_value = send key
        hash[:value] = field_value
      end
    end
  end
end
