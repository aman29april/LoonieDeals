# frozen_string_literal: true

# == Schema Information
#
# Table name: shareholding_patterns
#
#  id                       :integer          not null, primary key
#  date                     :date
#  institutions_holding     :float
#  non_institutions_holding :float
#  promoter_holding         :float
#  public_holding           :float
#  shareholder_name         :string
#  shareholding_percentage  :float
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  shareholding_period_id   :integer          not null
#
# Indexes
#
#  index_shareholding_patterns_on_shareholding_period_id  (shareholding_period_id)
#
# Foreign Keys
#
#  shareholding_period_id  (shareholding_period_id => shareholding_periods.id)
#
RSpec.describe ShareholdingPattern, type: :model do
  let(:company) { create(:company) }

  describe 'validations' do
    it { should belong_to(:company) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:shareholder_name) }
    it { should validate_presence_of(:shareholding_type) }
    it { should validate_presence_of(:shares_held) }
    it { should validate_presence_of(:shareholding_percentage) }
    it { should validate_numericality_of(:shares_held).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:shareholding_percentage).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:shareholding_percentage).is_less_than_or_equal_to(100) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'scopes' do
    describe '.latest' do
      it 'returns the latest shareholding pattern' do
        old_shareholding_pattern = create(:shareholding_pattern, company:, date: 1.month.ago)
        latest_shareholding_pattern = create(:shareholding_pattern, company:, date: Time.now)

        expect(described_class.latest(company)).to eq(latest_shareholding_pattern)
      end
    end
  end
end
