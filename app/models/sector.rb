# frozen_string_literal: true

# == Schema Information
#
# Table name: sectors
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sector < ApplicationRecord
  has_many :quotes

  validates :name, presence: true, uniqueness: true
  has_many :industries, class_name: 'Industry'
end
