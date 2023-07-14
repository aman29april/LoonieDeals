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
require 'rails_helper'

RSpec.describe Coupon, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
