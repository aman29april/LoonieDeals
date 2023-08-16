# frozen_string_literal: true

class ReferralCode < ApplicationRecord
  belongs_to :store
  acts_as_list

  validate :code_or_link_presence
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def code_or_link_presence
    return if code.present? || link.present?

    errors.add(:base, 'Either code or link must be present')
  end
end
