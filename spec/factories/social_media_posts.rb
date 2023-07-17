# frozen_string_literal: true

# == Schema Information
#
# Table name: social_media_posts
#
#  id                    :integer          not null, primary key
#  deal_id               :integer
#  social_media_accounts :text
#  text                  :text
#  scheduled_at          :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
FactoryBot.define do
  factory :social_media_post do
    deal { nil }
    account { 'MyText' }
    text { 'MyText' }
  end
end
