# == Schema Information
#
# Table name: monthly_prices
#
#  id                   :integer          not null, primary key
#  currency             :string           default("USD"), not null
#  days                 :integer
#  high_cents           :integer
#  integer              :string
#  last_day_close_cents :integer
#  low_cents            :integer
#  month                :string
#  volume               :integer
#  year                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  quote_id             :integer          not null
#
# Indexes
#
#  index_monthly_prices_on_quote_id                     (quote_id)
#  index_monthly_prices_on_quote_id_and_month_and_year  (quote_id,month,year) UNIQUE
#
# Foreign Keys
#
#  quote_id  (quote_id => quotes.id)
#
require 'rails_helper'

RSpec.describe MonthlyPrice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
