# frozen_string_literal: true

class Portfolio < ApplicationRecord
  belongs_to :popular_investor
  has_many :quotes

  def value
    quotes.sum(&:price)
  end
end
