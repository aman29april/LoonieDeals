# == Schema Information
#
# Table name: coupons
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  code            :string
#  discount        :decimal(, )
#  expiration_date :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :coupon do
    store { nil }
    code { 'MyString' }
    discount { '9.99' }
    expiration_date { '2023-07-09' }
  end
end
