# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id               :integer          not null, primary key
#  label            :string
#  image            :string
#  url              :string
#  number_of_clicks :integer          default(0)
#  pinned           :boolean          default(FALSE)
#  position         :integer
#  enabled          :boolean
#  deal_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
