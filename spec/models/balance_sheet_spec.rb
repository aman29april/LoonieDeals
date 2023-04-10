# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BalanceSheet, type: :model do
  subject { FactoryBot.create(:balance_sheet) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:total_assets) }
    it { should validate_numericality_of(:total_assets) }
    it { should validate_presence_of(:total_liabilities) }
    it { should validate_numericality_of(:total_liabilities) }
    it { should validate_presence_of(:total_equity) }
    it { should validate_numericality_of(:total_equity) }
    it { should validate_presence_of(:company_id) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
