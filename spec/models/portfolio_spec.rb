# frozen_string_literal: true

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
