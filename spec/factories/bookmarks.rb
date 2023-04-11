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
FactoryBot.define do
  factory :bookmark do
    user { nil }
    quote { nil }
  end
end
