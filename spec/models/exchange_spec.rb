# frozen_string_literal: true

# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  country    :string
#  currency   :string
#  full_name  :string
#  name       :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Exchange, type: :model do
  subject { FactoryBot.create(:exchange) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:companies).dependent(:destroy) }
  end
end
