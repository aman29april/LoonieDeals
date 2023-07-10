# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  description  :text
#  image        :string
#  name         :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  affiliate_id :string
#
FactoryBot.define do
  factory :store do
    name { "MyString" }
  end
end
