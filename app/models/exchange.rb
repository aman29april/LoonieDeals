# frozen_string_literal: true

# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  country    :string
#  currency   :string
#  name       :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Exchange < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :quotes, dependent: :destroy
end
