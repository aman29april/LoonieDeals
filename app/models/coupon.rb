# == Schema Information
#
# Table name: coupons
#
#  id              :integer          not null, primary key
#  code            :string
#  discount        :decimal(, )
#  expiration_date :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  store_id        :integer          not null
#
# Indexes
#
#  index_coupons_on_store_id  (store_id)
#
# Foreign Keys
#
#  store_id  (store_id => stores.id)
#
class Coupon < ApplicationRecord
  belongs_to :store
end
