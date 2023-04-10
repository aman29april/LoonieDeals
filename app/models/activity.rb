# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :quote

  belongs_to :portfolio

  enum action: {
    add_quote: 0,
    remove_quote: 1
  }
end
