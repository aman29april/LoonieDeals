# frozen_string_literal: true

class Sector < ApplicationRecord
  has_many :quotes
end
