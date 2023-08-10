# frozen_string_literal: true

class RecurringSchedule < ApplicationRecord
  belongs_to :deal

  enum recurrence_type: {
    weekly: 'weekly',
    monthly_day_of_week: 'monthly_day_of_week',
    monthly_day_of_month: 'monthly_day_of_month'
  }

  # For weekly recurring deals
  validates :recurrence_type, :day_of_week, presence: true, if: -> { weekly? }

  # For monthly recurring deals based on day of the week
  validates :recurrence_type, :day_of_week, presence: true, if: -> { monthly_day_of_week? }

  # For monthly recurring deals based on day of the month
  validates :recurrence_type, :day_of_month, presence: true, if: -> { monthly_day_of_month? }
end
