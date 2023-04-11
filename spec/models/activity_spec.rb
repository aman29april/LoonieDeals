# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  action       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  portfolio_id :integer          not null
#  quote_id     :integer          not null
#
# Indexes
#
#  index_activities_on_portfolio_id  (portfolio_id)
#  index_activities_on_quote_id      (quote_id)
#
# Foreign Keys
#
#  portfolio_id  (portfolio_id => portfolios.id)
#  quote_id      (quote_id => quotes.id)
#
require 'rails_helper'

RSpec.describe Activity, type: :model do
  context 'validations' do
    it 'is valid with a description' do
      activity = Activity.new(description: 'Added AAPL to portfolio')
      expect(activity).to be_valid
    end

    it 'is invalid without a description' do
      activity = Activity.new
      expect(activity).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a portfolio' do
      activity = Activity.reflect_on_association(:portfolio)
      expect(activity.macro).to eq(:belongs_to)
    end
  end
end
