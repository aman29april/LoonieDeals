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
class SiteSetting < ApplicationRecord
  # attr_encrypted :ig_secret_token, key: ENV['SECRET_TOKEN_ENCRYPTION_KEY']

  encrypts :ig_secret_token, :facebook_access_token, deterministic: true

  # validates :ig_id, :encrypted_ig_secret_token, presence: true

  def self.instance
    first_or_create!
  end
end
