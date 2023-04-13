# frozen_string_literal: true

# == Schema Information
#
# Table name: dividends
#
#  id               :integer          not null, primary key
#  amount_cents     :integer
#  currency         :string           default("USD"), not null
#  date             :date
#  declaration_date :date
#  payment_date     :date
#  record_date      :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  quote_id         :integer          not null
#
# Indexes
#
#  index_dividends_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
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
