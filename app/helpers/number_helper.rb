# frozen_string_literal: true

module NumberHelper
  # Shows number in million
  # also shows negative numbers in paranthesis.
  def format_number(value, zero_as_blank: true, precision: 0)
    return '--' if zero_as_blank && value.to_f.zero?

    to_million(value)
    money = humanized_money(to_million(value))
    money = money.split('.').first if precision.zero?

    money.include?('-') ? "(#{money.gsub('-', '')})" : money
  end

  def format_value(value, options = {})
    format = options[:format]

    case format
    when :as_it_is
      value
    when :ratio
      format_precision(value * 100, 1)
    when :percentage
      format_percentage(value * 100, 1)
    when :number
      value
    else
      format_number(value)
    end
  end

  def to_million(value)
    return if value.blank?

    value / (10**6)
  end

  def percentage_change(old_value, new_value)
    return if old_value.blank? || new_value.blank? || old_value.zero? || new_value.zero?
    return if old_value.class != new_value.class

    if old_value.instance_of?(Money)
      old_value = old_value.cents
      new_value = new_value.cents
    end
    change = (new_value - old_value).to_f
    (change / old_value.abs) * 100
  end
end
