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
class Deal < ApplicationRecord
  belongs_to :store

  has_one_attached :image
end
