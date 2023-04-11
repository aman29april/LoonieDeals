# frozen_string_literal: true

# == Schema Information
#
# Table name: company_peers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer          not null
#  peer_id    :integer          not null
#
# Indexes
#
#  index_company_peers_on_company_id  (company_id)
#  index_company_peers_on_peer_id     (peer_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#  peer_id     (peer_id => peers.id)
#
class CompanyPeer < ApplicationRecord
  belongs_to :company
  belongs_to :peer, class_name: 'Company'
end
