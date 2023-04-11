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
FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    event_type { Event::TYPES.sample }
    date { Faker::Date.between(from: 2.years.ago, to: Date.today) }
    description { Faker::Lorem.paragraph }
    company { create(:company) }
  end
end
