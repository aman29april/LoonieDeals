# frozen_string_literal: true

module QuotesHelper
  def financial_data_to_table(data, structure)
    cols = []
    table = []

    structure.each { |_k, v| cols << { formatted_value: v[:text] } }
    table.insert(0, cols)

    data.each do |balance_sheet|
      hash = balance_sheet.to_row
      row = []
      hash.each do |_field, map|
        map[:formatted_value] = format_value(map[:value], map)
        row << map.slice(:formatted_value, :value)
      end
      table << row
    end

    table.transpose
  end

  def format_value(value, options = {})
    format = options[:format]

    case format
    when :as_it_is
      value
    when :number
      value
    else
      format_number(value)
    end
  end

  # Shows number in million
  # also shows negative numbers in paranthesis.
  def format_number(value)
    return '--' if value.blank?

    in_million = to_million(value)
    money = humanized_money to_million(value), percision: 2
    money.include?('-') ? "(#{money.gsub('-', '')})" : money
  end

  def to_million(value)
    return if value.blank?

    value / (10**6)
  end
end
