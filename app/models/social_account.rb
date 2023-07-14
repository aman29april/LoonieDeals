# == Schema Information
#
# Table name: social_accounts
#
#  id               :integer          not null, primary key
#  url              :string
#  number_of_clicks :integer          default(0)
#  position         :integer
#  account_type     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class SocialAccount < ApplicationRecord
end
