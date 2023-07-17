# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  deals_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_many :deals
  validates :name, presence: true, uniqueness: true

  has_one_attached :image

  scope :by_deals, -> { order(deals_count: :desc) }
end
