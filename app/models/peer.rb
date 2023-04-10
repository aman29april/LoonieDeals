# frozen_string_literal: true

class Peer < ApplicationRecord
  belongs_to :company
  belongs_to :peer_company
end
