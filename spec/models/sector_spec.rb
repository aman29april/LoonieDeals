# frozen_string_literal: true

# == Schema Information
#
# Table name: sectors
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Sector, type: :model do
  context 'validations' do
    it 'is valid with a name' do
      sector = Sector.new(name: 'Technology')
      expect(sector).to be_valid
    end

    it 'is invalid without a name' do
      sector = Sector.new
      expect(sector).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many quotes' do
      sector = Sector.reflect_on_association(:quotes)
      expect(sector.macro).to eq(:has_many)
    end
  end
end
