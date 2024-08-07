# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def format_precision(amount, precision)
    "%0.#{precision}f" % amount unless amount.nil?
  end

  def format_percentage(amount, precision = 0)
    "#{"%0.#{precision}f" % amount}%" unless amount.nil?
  end

  def json_images(images)
    return [].to_json if images.blank? || !images.attached?

    attachments = images.attachments
    # images_array = images.is_a?(Array) ? images : images.nil? ? [] : [images]
    attachments.map do |image|
      {
        accepted: true,
        id: image.id,
        name: image.blob.filename,
        url: attachment_url(image),

        size: image.blob.byte_size
      }
    end.to_json
  end

  def dropzone_existing_images(images)
    json_images(images)
  end

  def dropzone_controller_div(options = {}, &block)
    max_files = [1, options[:max_files]].compact.max
    json_images(options[:existing_images])
    data = {
      controller: 'dropzone',
      'dropzone-max-file-size' => '8',
      'dropzone-max-files' => max_files.to_s,
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif',
      'dropzone-dict-file-too-big' => 'File Size is {{filesize}}, which exceeds the maximum allowed {{maxFilesize}} MB',
      'dropzone-dict-invalid-file-type' => 'Only .jpeg, .jpg, .png  .gif allowed',
      'dropzone-previews-container' => '#dropzone-previews-container',
      'dropzone-add-remove-links' => 'true',
      'dropzone-dict-remove-file' => 'true'
      # 'dropzone-existing-files' => existing_images
    }
    css_class = ['dropzone dropzone-default dz-clickable', options[:class]].compact.join(' ')
    content_tag(:div, class: css_class, data:, &block)
  end

  def dropzone_container(options = {})
    dropzone_controller_div(options) do
    end
  end

  def resource_image(image, options = {})
    return image_tag(image, options) if image.instance_of?(String)

    url = image.attached? ? resource_image_url(image) : '/assets/no_image_available.svg'
    image_tag url, options
  end

  def resource_image_url(image)
    return unless image.attached?

    cloudinary_url(image.attachment.key)
  end

  def attachment_url(attachment)
    cloudinary_url(attachment.key)
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
      telegram: 'https://t.me/+Vjt0oVITxa44MmM9',
      website: '/'
    }
  end

  def to_human_hashtag(input_string)
    capitalized_words = input_string.split.map(&:capitalize)
    "##{capitalized_words.join}"
  end
end
