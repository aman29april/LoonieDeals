# frozen_string_literal: true

# == Schema Information
#
# Table name: shareholding_periods
#
#  id          :integer          not null, primary key
#  end_date    :date
#  period_type :string
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quote_id    :integer          not null
#
# Indexes
#
#  index_shareholding_periods_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class ShareholdingPeriod < ApplicationRecord
  belongs_to :quote
  has_many :shareholding_patterns
end
