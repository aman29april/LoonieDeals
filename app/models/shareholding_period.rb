# frozen_string_literal: true

class ShareholdingPeriod < ApplicationRecord
  belongs_to :quote
  has_many :shareholding_patterns
end
