# frozen_string_literal: true

module FinancialStatementHelper
  extend ActiveSupport::Concern

  included do
    validates :calendar_year, uniqueness: { scope: %i[quote_id period] }

    scope :by_year_n_quarter, -> { yearly.order(calendar_year: :asc) }

    scope :yearly, -> { where(period: 'FY') }
    scope :quarterly, -> { where.not.call(period: 'FY') }

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
