# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  context 'associations' do
    it 'belongs to a user' do
      bookmark = Bookmark.reflect_on_association(:user)
      expect(bookmark.macro).to eq(:belongs_to)
    end

    it 'belongs to a quote' do
      bookmark = Bookmark.reflect_on_association(:quote)
      expect(bookmark.macro).to eq(:belongs_to)
    end
  end
end
