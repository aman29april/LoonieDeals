# frozen_string_literal: true

class RecurringSchedule < ApplicationRecord
  belongs_to :deal

  enum recurrence_type: {
    weekly: 'weekly',
    monthly_day_of_week: 'monthly_day_of_week',
    monthly_day_of_month: 'monthly_day_of_month'
  }

  validates :recurrence_type, :deal_id, presence: true

  # For weekly recurring deals
  validates :day_of_week, presence: true, if: -> { weekly? }

  # For monthly recurring deals based on day of the week
  validates :day_of_week, presence: true, if: -> { monthly_day_of_week? }

  # For monthly recurring deals based on day of the month
  validates :day_of_month, presence: true, if: -> { monthly_day_of_month? }

  scope :this_week, -> { valid.by_day_of_week }

  scope :by_day_of_week, -> { order(day_of_week: :asc) }
  scope :for_today, -> { where(day_of_week: Date.current.wday) }

  scope :valid, lambda {
    start_of_week = Time.now.beginning_of_week
    end_of_week = Time.now.end_of_week
    where('(starts_at IS NULL OR starts_at >= ?) AND (expires_at IS NULL OR expires_at <= ?)', start_of_week, end_of_week)
  }

  def self.upcoming_deals
    this_week.map(&:deal)
  end
end
