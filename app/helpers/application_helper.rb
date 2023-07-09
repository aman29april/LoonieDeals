# frozen_string_literal: true

module ApplicationHelper
  def format_precision(amount, precision)
    "%0.#{precision}f" % amount unless amount.nil?
  end

  def format_percentage(amount, precision)
    "#{"%0.#{precision}f" % amount}%" unless amount.nil?
  end
end
