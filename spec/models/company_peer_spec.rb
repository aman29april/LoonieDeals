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
require 'rails_helper'

RSpec.describe CompanyPeer, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:peer).class_name('Company') }
  end

  describe 'validations' do
    let(:company) { create(:company) }
    let(:peer) { create(:company) }
    let(:company_peer) { create(:company_peer, company:, peer:) }

    it { should validate_uniqueness_of(:peer_id).scoped_to(:company_id) }

    it 'validates presence of company' do
      expect(build(:company_peer, company: nil)).not_to be_valid
    end

    it 'validates presence of peer' do
      expect(build(:company_peer, peer: nil)).not_to be_valid
    end

    it 'does not allow a company to be its own peer' do
      expect(build(:company_peer, company:, peer: company)).not_to be_valid
    end

    it 'does not allow the same peer to be added more than once for a company' do
      expect(build(:company_peer, company: company_peer.company, peer: company_peer.peer)).not_to be_valid
    end
  end
end
