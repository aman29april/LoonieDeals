# frozen_string_literal: true

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
