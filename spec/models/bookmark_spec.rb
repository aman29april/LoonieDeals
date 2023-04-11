# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quote_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_bookmarks_on_quote_id  (quote_id)
#  index_bookmarks_on_user_id   (user_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#  user_id   (user_id => users.id)
#
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
