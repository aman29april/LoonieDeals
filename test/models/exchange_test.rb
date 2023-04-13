# frozen_string_literal: true

# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  country    :string
#  currency   :string
#  full_name  :string
#  name       :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class ExchangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
