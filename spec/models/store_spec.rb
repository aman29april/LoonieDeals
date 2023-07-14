# == Schema Information
#
# Table name: stores
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  website          :string
#  affiliate_id     :string
#  featured         :boolean          default(FALSE)
#  slug             :string
#  meta_keywords    :string
#  meta_description :string
#  deals_count      :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Store, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
