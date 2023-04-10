# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :quote

  validates :date, presence: true
  validates :event_type, presence: true, inclusion: { in: %w[announcement corporate_action dividend_announcement] }
end
