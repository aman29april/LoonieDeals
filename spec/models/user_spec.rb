# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with an email and password' do
      user = User.new(email: 'user@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = User.new(password: 'password')
      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user = User.new(email: 'user@example.com')
      expect(user).to_not be_valid
    end

    it 'is invalid with a duplicate email' do
      User.create(email: 'user@example.com', password: 'password')
      user = User.new(email: 'user@example.com', password: 'password')
      expect(user).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many bookmarks' do
      user = User.reflect_on_association(:bookmarks)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many popular investors' do
      user = User.reflect_on_association(:popular_investors)
      expect(user.macro).to eq(:has_many)
    end
  end
end
