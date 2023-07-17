# frozen_string_literal: true

# == Schema Information
#
# Table name: social_media_posts
#
#  id                    :integer          not null, primary key
#  deal_id               :integer
#  social_media_accounts :text
#  text                  :text
#  scheduled_at          :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe SocialMediaPost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
