# frozen_string_literal: true

class Company < Quote
  belongs_to :exchange

  has_many :company_peers
end
