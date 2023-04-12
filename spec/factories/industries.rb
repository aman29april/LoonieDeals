# frozen_string_literal: true

# == Schema Information
#
# Table name: industries
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sector_id   :integer          not null
#
# Indexes
#
#  index_industries_on_sector_id  (sector_id)
#
# Foreign Keys
#
#  sector_id  (sector_id => sectors.id)
#
FactoryBot.define do
  factory :industry do
    name { 'MyString' }
    description { 'MyText' }
  end
end
