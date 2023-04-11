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
