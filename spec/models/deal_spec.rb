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
require 'rails_helper'

RSpec.describe Deal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
