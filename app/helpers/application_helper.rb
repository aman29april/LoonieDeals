# frozen_string_literal: true

module ApplicationHelper
  def format_precision(amount, precision)
    "%0.#{precision}f" % amount unless amount.nil?
  end

  def format_percentage(amount, precision = 0)
    "#{"%0.#{precision}f" % amount}%" unless amount.nil?
  end

  def dropzone_controller_div(options = {}, &block)
    content_for :head_link do
      # tag :link, rel: 'stylesheet', href: 'https://unpkg.com/dropzone@5/dist/min/dropzone.min.css', type: 'text/css'
    end

    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => '8',
      'dropzone-max-files' => '1',
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif',
      'dropzone-dict-file-too-big' => 'File Size is {{filesize}}, which exceeds the maximum allowed {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => 'Only .jpeg, .jpg, .png  .gif allowed',
      'dropzone-previews-container' => '#dropzone-previews-container'
    }
    css_class = ['dropzone dropzone-default dz-clickable', options[:class]].compact.join(' ')
    content_tag(:div, class: css_class, data:, &block)
  end

  def resource_image(image, options = {})
    return unless image.attached?

    # image_tag(url_for(image.representation(resize: '300x200', quality: 90)), options)

    # image_tag url_for(image.representation(resize_to_limit: [300, 300]).processed), options

    url = resource_image_url(image)
    image_tag url, options
  end

  def resource_image_url(image)
    return unless image.attached?

    cloudinary_url(image.attachment.key)
  end

  def format_number(number, zero_as_blank: false, precision: 2)
    return '' if zero_as_blank && number.to_f.zero?

    number_with_precision(number.to_f, precision:)
  end

  def to_money(amount, zero_as_blank: true, currency: '$')
    formatted_amount = number_to_currency(amount, unit: currency, precision: 2)
    formatted_amount.sub(/\.?0+$/, '')
  end

  def display_money(amount, zero_as_blank: true, currency: '$')
    formatted_amount = number_to_currency(amount, unit: currency, precision: 2)
    value_with_zero_trimmed = formatted_amount.sub(/\.?0+$/, '').html_safe
    content_tag(:span, value_with_zero_trimmed, class: 'money')
  end

  def whatsapp_share_url(url, text = '')
    msg = [text, url].reject(&:blank?).join(' - ')
    "https://api.whatsapp.com/send?text=#{msg}"
  end

  def telegram_share_url(url, text)
    "https://t.me/share/url?url=#{url}&text=#{text}"
  end

  def twitter_share_url(url, text)
    "http://twitter.com/share?text=#{text} - =#{url}"
  end

  def facebook_share_url(url)
    "http://www.facebook.com/sharer.php?u=#{url}"
  end

  def javascript_window_open(url)
    "javascript:window.open('#{url}', '_blank', 'width=800, height=500, top=200, left=300');void(0)"
  end

  def time_ago(datetime)
    value = time_ago_in_words(datetime)

    content_tag(:time, value, title: datetime, datetime:)
  end

  def display_text(text, length = 50)
    truncated = truncate(text, length:)
    content_tag(:span, truncated, title: text)
  end

  def social_handles
    {
      whatsapp: 'https://chat.whatsapp.com/IfLLCVdYyVH92bPgeG8nuU',
      facebook: 'https://www.facebook.com/profile.php?id=100094613855327',
      instagram: 'https://www.instagram.com/looniedeals.ca/',
      telegram: 'https://t.me/+Vjt0oVITxa44MmM9'
    }
  end
end
