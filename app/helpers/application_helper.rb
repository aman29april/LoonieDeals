# frozen_string_literal: true

module ApplicationHelper
  def format_precision(amount, precision)
    "%0.#{precision}f" % amount unless amount.nil?
  end

  def format_percentage(amount, precision)
    "#{"%0.#{precision}f" % amount}%" unless amount.nil?
  end

  def dropzone_controller_div
    content_for :head_link do
      tag :link, rel: "stylesheet", href: "https://unpkg.com/dropzone@5/dist/min/dropzone.min.css", type: "text/css"
    end
    
    data = {
      controller: "dropzone",
      'dropzone-max-file-size'=>"8",
      'dropzone-max-files' => "10",
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif',
      'dropzone-dict-file-too-big' => "Váš obrázok ma veľkosť {{filesize}} ale povolené sú len obrázky do veľkosti {{maxFilesize}} MB",
      'dropzone-dict-invalid-file-type' => "Nesprávny formát súboru. Iba obrazky .jpg, .png alebo .gif su povolene",
    }

    content_tag :div, class: 'dropzone dropzone-default dz-clickable', data: data do
      yield
    end
  end
end
