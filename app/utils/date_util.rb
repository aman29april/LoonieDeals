# frozen_string_literal: true

module DateUtil
  def self.end_of_next_wednesday
    current_date = Time.now
    days_until_next_wednesday = (3 - current_date.wday) % 7
    next_wednesday = current_date + days_until_next_wednesday.days
    end_of_next_wednesday = next_wednesday.end_of_day
  end

  def self.flyer_start_end_dates
    today = Date.today
    current_week_start = today.at_beginning_of_week
    current_week_end = today.at_end_of_week
    
    if end_of_next_wednesday >= current_week_start && end_of_next_wednesday <= current_week_end
      ending = end_of_next_wednesday + 7.days
    else
      ending = end_of_next_wednesday 
    end

    start = (ending - 6.days).beginning_of_day
    [start, ending]
  end
end
