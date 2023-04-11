# frozen_string_literal: true

# == Schema Information
#
# Table name: ratios
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :decimal(, )
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer          not null
#
# Indexes
#
#  index_ratios_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
RSpec.describe Ratio, type: :model do
  let(:company) { create(:company) }
  let(:ratio) { create(:ratio, company:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(ratio).to be_valid
    end

    it 'is not valid without a name' do
      ratio.name = nil
      expect(ratio).to_not be_valid
    end

    it 'is not valid without a value' do
      ratio.value = nil
      expect(ratio).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a company' do
      expect(ratio.company).to eq(company)
    end
  end

  describe 'scopes' do
    let!(:company1) { create(:company) }
    let!(:ratio1) { create(:ratio, company: company1, name: 'PE Ratio', value: 20) }
    let!(:ratio2) { create(:ratio, company: company1, name: 'ROE', value: 15) }
    let!(:company2) { create(:company) }
    let!(:ratio3) { create(:ratio, company: company2, name: 'PE Ratio', value: 30) }

    it 'can filter by name' do
      expect(Ratio.by_name('PE Ratio')).to eq([ratio1, ratio3])
    end

    it 'can filter by value greater than or equal to' do
      expect(Ratio.by_value_gte(20)).to eq([ratio1, ratio3])
    end

    it 'can filter by value less than or equal to' do
      expect(Ratio.by_value_lte(15)).to eq([ratio2])
    end

    it 'can filter by company id' do
      expect(Ratio.by_company_id(company1.id)).to eq([ratio1, ratio2])
    end
  end
end
