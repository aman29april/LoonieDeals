# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe SplitHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
