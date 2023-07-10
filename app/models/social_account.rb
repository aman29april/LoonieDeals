# == Schema Information
#
# Table name: social_accounts
#
#  id           :integer          not null, primary key
#  account_type :integer          not null
#  url          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_social_accounts_on_user_id  (user_id)
#
class SocialAccount < ApplicationRecord
  belongs_to :user
  enum account_type: %i[github facebook twitter linkedin stackoverflow]

  validates :user, presence: true

  validates :url, presence: true,
                  uniqueness: true,
                  format: { with: URI::DEFAULT_PARSER.make_regexp }

  validates :account_type,
            presence: true,
            inclusion: { in: SocialAccount.account_types.keys },
            uniqueness: { message: '%<value>s is already used' }
end
