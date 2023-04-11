# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  description :text
#  event_type  :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quote_id    :integer          not null
#
# Indexes
#
#  index_events_on_quote_id  (quote_id)
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
class Event < ApplicationRecord
  belongs_to :quote

  validates :date, presence: true
  validates :event_type, presence: true, inclusion: { in: %w[announcement corporate_action dividend_announcement] }
end
