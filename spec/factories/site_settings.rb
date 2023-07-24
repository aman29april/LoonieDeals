# frozen_string_literal: true

# == Schema Information
#
# Table name: site_settings
#
#  id                        :integer          not null, primary key
#  ig_id                     :string
#  encrypted_ig_secret_token :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  encrypted_secret_token    :string
#
FactoryBot.define do
  factory :site_setting do
    ig_id { 'MyString' }
    secret_token { 'MyString' }
  end
end
