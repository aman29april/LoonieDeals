# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CashFlow, type: :model do
  subject { FactoryBot.create(:cash_flow) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:cash_from_operating_activities) }
  end
end
