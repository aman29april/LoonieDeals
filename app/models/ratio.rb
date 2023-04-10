# frozen_string_literal: true

# app/models/ratio.rb
class Ratio < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :value, presence: true

  scope :by_name, ->(name) { where(name:) }
  scope :by_company, ->(company_id) { where(company_id:) }

  def self.calculate_ratios(company_id)
    company = Company.find(company_id)

    # Calculate profitability ratios
    gross_profit_margin = (company.revenue - company.cost_of_goods_sold) / company.revenue.to_f
    net_profit_margin = company.net_income / company.revenue.to_f
    return_on_equity = company.net_income / company.shareholders_equity.to_f

    # Calculate liquidity ratios
    current_ratio = company.current_assets / company.current_liabilities.to_f
    quick_ratio = (company.current_assets - company.inventory) / company.current_liabilities.to_f

    # Create ratio records
    Ratio.create(name: 'Gross Profit Margin', value: gross_profit_margin, company_id: company.id)
    Ratio.create(name: 'Net Profit Margin', value: net_profit_margin, company_id: company.id)
    Ratio.create(name: 'Return on Equity', value: return_on_equity, company_id: company.id)
    Ratio.create(name: 'Current Ratio', value: current_ratio, company_id: company.id)
    Ratio.create(name: 'Quick Ratio', value: quick_ratio, company_id: company.id)
  end
end
