# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PopularInvestor, type: :model do
  context 'associations' do
    it 'belongs to a user' do
      popular_investor = PopularInvestor.reflect_on_association(:user)
      expect(popular_investor.macro).to eq(:belongs_to)
    end

    it 'has many portfolios' do
      popular_investor = PopularInvestor.reflect_on_association(:portfolios)
      expect(popular_investor.macro).to eq(:has_many)
    end
  end
end
