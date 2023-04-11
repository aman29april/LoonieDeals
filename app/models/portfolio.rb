# frozen_string_literal: true

# == Schema Information
#
# Table name: portfolios
#
#  id                   :integer          not null, primary key
#  number_of_shares     :integer
#  quarter              :integer
#  year                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  popular_investors_id :integer          not null
#
# Indexes
#
#  index_portfolios_on_popular_investors_id  (popular_investors_id)
#
# Foreign Keys
#
#  popular_investors_id  (popular_investors_id => popular_investors.id)
#
class Portfolio < ApplicationRecord
  belongs_to :popular_investor
  has_many :quotes

  def value
    quotes.sum(&:price)
  end
end
