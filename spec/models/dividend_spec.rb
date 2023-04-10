# frozen_string_literal: true

RSpec.describe Dividend, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:announcement_date) }
    it { should validate_presence_of(:ex_date) }
    it { should validate_presence_of(:record_date) }
    it { should validate_presence_of(:pay_date) }
    it { should validate_presence_of(:dividend_per_share) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
