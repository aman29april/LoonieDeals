# frozen_string_literal: true

# == Schema Information
#
# Table name: site_settings
#
#  id                        :integer          not null, primary key
#  ig_id                     :string
#  encrypted_ig_secret_token :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  encrypted_secret_token    :string
#
require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
