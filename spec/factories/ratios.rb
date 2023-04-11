# frozen_string_literal: true

# == Schema Information
#
# Table name: ratios
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :decimal(, )
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer          not null
#
# Indexes
#
#  index_ratios_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
FactoryBot.define do
  factory :ratio do
    name { 'MyString' }
    value { '9.99' }
    year { 1 }
    company { nil }
  end
end
