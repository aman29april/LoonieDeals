# frozen_string_literal: true

# == Schema Information
#
# Table name: popular_investors
#
#  id         :integer          not null, primary key
#  age        :integer
#  bio        :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PopularInvestor < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :bio, length: { maximum: 500 }

  def add_to_portfolio(quote)
    portfolio << quote
  end

  def portfolio_value
    portfolio.sum(&:price)
  end
end
