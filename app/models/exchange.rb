# frozen_string_literal: true

class Exchange < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :quotes, dependent: :destroy
end
