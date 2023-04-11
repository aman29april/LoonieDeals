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
require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  context 'associations' do
    it 'belongs to a popular investor' do
      portfolio = Portfolio.reflect_on_association(:popular_investor)
      expect(portfolio.macro).to eq(:belongs_to)
    end

    it 'has many activities' do
      portfolio = Portfolio.reflect_on_association(:activities)
      expect(portfolio.macro).to eq(:has_many)
    end

    it 'has many quotes' do
      portfolio = Portfolio.reflect_on_association(:quotes)
      expect(portfolio.macro).to eq(:has_many)
    end
  end
end
