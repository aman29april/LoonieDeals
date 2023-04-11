# frozen_string_literal: true

# == Schema Information
#
# Table name: peers
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer          not null
#  peer_company_id :integer          not null
#
# Indexes
#
#  index_peers_on_company_id       (company_id)
#  index_peers_on_peer_company_id  (peer_company_id)
#
# Foreign Keys
#
#  company_id       (company_id => companies.id)
#  peer_company_id  (peer_company_id => peer_companies.id)
#
FactoryBot.define do
  factory :peer do
    company { nil }
    peer_company { nil }
  end
end
