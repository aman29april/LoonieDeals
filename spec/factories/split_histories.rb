# == Schema Information
#
# Table name: split_histories
#
#  id          :integer          not null, primary key
#  date        :date
#  denominator :integer
#  numerator   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quote_id    :integer          not null
#
# Indexes
#
#  index_split_histories_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
FactoryBot.define do
  factory :split_history do
    quote { nil }
    date { '2023-04-12' }
    numerator { 1 }
    denominator { 1 }
  end
end
