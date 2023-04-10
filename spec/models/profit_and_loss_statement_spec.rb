# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfitAndLossStatement, type: :model do
  subject { FactoryBot.create(:profit_and_loss_statement) }

  describe 'validations' do
    it { should validate_presence_of(:fiscal_period) }
    it { should validate_presence_of(:revenue) }
    it { should validate_numericality_of(:revenue) }
    it { should validate_presence_of(:cost_of_revenue) }
    it { should validate_numericality_of(:cost_of_revenue) }
    it { should validate_presence_of(:gross_profit) }
    it { should validate_numericality_of(:gross_profit) }
    it { should validate_presence_of(:operating_expenses) }
    it { should validate_numericality_of(:operating_expenses) }
    it { should validate_presence_of(:operating_income) }
    it { should validate_numericality_of(:operating_income) }
    it { should validate_presence_of(:net_income) }
    it { should validate_numericality_of(:net_income) }
    it { should validate_presence_of(:company_id) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
