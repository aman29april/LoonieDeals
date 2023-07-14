# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  body             :text
#  price            :decimal(, )
#  retail_price     :decimal(, )
#  discount         :decimal(, )
#  url              :string
#  pinned           :boolean          default(FALSE)
#  published_at     :datetime
#  featured         :boolean          default(FALSE)
#  slug             :string
#  short_slug       :string
#  meta_keywords    :string
#  meta_description :string
#  expiration_date  :datetime
#  view_count       :integer          default(0)
#  upvotes          :integer          default(0)
#  downvotes        :integer          default(0)
#  store_id         :integer          not null
#  category_id      :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :deal do
    store { nil }
    title { 'MyString' }
    description { 'MyText' }
    price { '9.99' }
    discount { '9.99' }
    expiration_date { '2023-07-09' }
  end
end
