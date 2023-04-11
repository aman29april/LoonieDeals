# frozen_string_literal: true

# == Schema Information
#
# Table name: shareholding_periods
#
#  id          :integer          not null, primary key
#  end_date    :date
#  period_type :string
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quote_id    :integer          not null
#
# Indexes
#
#  index_shareholding_periods_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
# spec/models/shareholding_period_spec.rb
require 'rails_helper'

RSpec.describe ShareholdingPeriod, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      shareholding_period = build(:shareholding_period)
      expect(shareholding_period).to be_valid
    end

    it 'is not valid without a start_date' do
      shareholding_period = build(:shareholding_period, start_date: nil)
      expect(shareholding_period).not_to be_valid
    end

    it 'is not valid without an end_date' do
      shareholding_period = build(:shareholding_period, end_date: nil)
      expect(shareholding_period).not_to be_valid
    end

    it 'is not valid with an end_date before the start_date' do
      shareholding_period = build(:shareholding_period, start_date: Date.today, end_date: Date.yesterday)
      expect(shareholding_period).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:shareholding_pattern).dependent(:destroy) }
  end
end
