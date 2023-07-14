# frozen_string_literal: true

module ApplicationHelper
  def format_precision(amount, precision)
    "%0.#{precision}f" % amount unless amount.nil?
  end

  def format_percentage(amount, precision)
    "#{"%0.#{precision}f" % amount}%" unless amount.nil?
  end

  def dropzone_controller_div(&block)
    content_for :head_link do
      tag :link, rel: 'stylesheet', href: 'https://unpkg.com/dropzone@5/dist/min/dropzone.min.css', type: 'text/css'
    end

    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => '8',
      'dropzone-max-files' => '10',
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif',
      'dropzone-dict-file-too-big' => 'Váš obrázok ma veľkosť {{filesize}} ale povolené sú len obrázky do veľkosti {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => 'Nesprávny formát súboru. Iba obrazky .jpg, .png alebo .gif su povolene'
    }

    content_tag(:div, class: 'dropzone dropzone-default dz-clickable', data:, &block)
  end

  def resource_image(image, options = {})
     if image.attached?
        image_tag(url_for(image.representation(resize: '300x200', quality: 90)), options)

        image_tag url_for(image.representation(resize_to_limit: [300, 300]).processed), options
     end
  end

  def format_number(number, zero_as_blank: false, precision: 2)
    return '' if zero_as_blank && number.to_f.zero?
    number_with_precision(number.to_f, precision: precision)
  end

  def display_money(amount, zero_as_blank: true, currency: '$')
    formatted_amount = number_to_currency(amount, unit: currency, precision: 2)
    value_with_zero_trimmed = formatted_amount.sub(/\.?0+$/, '').html_safe
    content_tag(:span, value_with_zero_trimmed, class: 'money')
  end
end
