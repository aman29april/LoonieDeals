# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id               :integer          not null, primary key
#  label            :string
#  image            :string
#  url              :string
#  number_of_clicks :integer          default(0)
#  pinned           :boolean          default(FALSE)
#  position         :integer
#  enabled          :boolean
#  deal_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :link do
    text { 'MyString' }
    image_url { 'MyString' }
    link_url { 'MyString' }
    order_number { 1 }
    deal { nil }
  end
end
