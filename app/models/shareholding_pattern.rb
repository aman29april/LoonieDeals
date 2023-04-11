# frozen_string_literal: true

# == Schema Information
#
# Table name: shareholding_patterns
#
#  id                       :integer          not null, primary key
#  date                     :date
#  institutions_holding     :float
#  non_institutions_holding :float
#  promoter_holding         :float
#  public_holding           :float
#  shareholder_name         :string
#  shareholding_percentage  :float
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  shareholding_period_id   :integer          not null
#
# Indexes
#
#  index_shareholding_patterns_on_shareholding_period_id  (shareholding_period_id)
#
# Foreign Keys
#
#  shareholding_period_id  (shareholding_period_id => shareholding_periods.id)
#
class ShareholdingPattern < ApplicationRecord
  belongs_to :shareholding_period
end
