# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe Deal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
