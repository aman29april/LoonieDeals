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
class SplitHistory < ApplicationRecord
  belongs_to :quote
end
