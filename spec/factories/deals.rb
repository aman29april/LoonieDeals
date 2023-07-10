# == Schema Information
#
# Table name: deals
#
#  id              :integer          not null, primary key
#  description     :text
#  discount        :decimal(, )
#  expiration_date :date
#  pinned          :boolean
#  price           :decimal(, )
#  title           :string
#  url             :string
#  view_count      :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  store_id        :integer          not null
#
# Indexes
#
#  index_deals_on_store_id  (store_id)
#
# Foreign Keys
#
#  store_id  (store_id => stores.id)
#
FactoryBot.define do
  factory :deal do
    store { nil }
    title { "MyString" }
    description { "MyText" }
    price { "9.99" }
    discount { "9.99" }
    expiration_date { "2023-07-09" }
  end
end
