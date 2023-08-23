# frozen_string_literal: true

module DateUtil
  def self.end_of_next_wednesday
    current_date = Time.now
    days_until_next_wednesday = (3 - current_date.wday) % 7
    next_wednesday = current_date + days_until_next_wednesday.days
    next_wednesday.end_of_day
  end
end
