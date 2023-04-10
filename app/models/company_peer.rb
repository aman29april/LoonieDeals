# frozen_string_literal: true

class CompanyPeer < ApplicationRecord
  belongs_to :company
  belongs_to :peer, class_name: 'Company'
end
