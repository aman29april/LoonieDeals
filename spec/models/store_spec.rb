# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  description  :text
#  image        :string
#  name         :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  affiliate_id :string
#
require 'rails_helper'

RSpec.describe Store, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
