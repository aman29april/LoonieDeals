# frozen_string_literal: true

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
