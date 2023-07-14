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
class Coupon < ApplicationRecord
  belongs_to :store
end
