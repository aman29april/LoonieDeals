# frozen_string_literal: true

class Dividend < ApplicationRecord
  belongs_to :quote

  validates :record_date, presence: true
  validates :payment_date, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
