# frozen_string_literal: true

class QuotePrice < ApplicationRecord
  belongs_to :quote

  validates :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
