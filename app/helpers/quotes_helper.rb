# frozen_string_literal: true

module QuotesHelper
  def financial_data_to_table(data, structure, options = {})
    data = transpose_data(data, structure)

    return convert_to_percentage(data) if options[:view] == 'growth'

    data
  end

  def convert_to_percentage(data)
    table = data.dup
    table.each do |rows|
      rows.each_with_index do |map, index|
        if index.zero?
          map[:percentage] = ''
          next
        end
        next if map[:value].blank? || map[:value].zero?

        prev_index = index - 1
        current_value = map[:value]
        prev_value = rows[prev_index][:value]
        percentage = percentage_change(prev_value, current_value)
        map.merge!(
          percentage:,
          tooltip: map[:formatted_value],
          formatted_value: format_percentage(percentage, 0),
          class: fs_data_class(percentage)
        )
      end
    end
    table
  end

  def transpose_data(data, structure)
    cols = []
    table = []

    structure.each { |_k, v| cols << { formatted_value: v[:text] } }
    table.insert(0, cols)

    data.each do |record|
      row_hash = record.to_row
      row = []
      row_hash.each do |field, map|
        map[:key] = field
        map[:formatted_value] = format_value(map[:value], map)
        # row << map.slice(:formatted_value, :value, :tooltip, :key, :class)
        row << map.dup
      end
      table << row
    end

    table.transpose
  end

  def table_row_class(row)
    klass = []
    klass << 'font-weight-bold' if row[:bold] == true
    if row[:highlight] == true
      klass << 'table-warning'
      klass << 'font-weight-bold'
    end
    klass.uniq.join(' ')
  end

  def fs_data_class(value)
    value = value.to_s
    return 'negative' if value.starts_with?('-')
    return '' if value == '0%'

    'positive'
  end
end
