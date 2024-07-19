# frozen_string_literal: true

module UrlUtil
  def self.remove_affiliate_tag(url)
    affiliate_tag_regex = /(?:\?|&)tag=[^&]+/
    url.gsub(affiliate_tag_regex, '')
  end

  def self.replace_affiliate_tag(url, new_tag)
    return url if already_has_our_affiliate?(url)

    cleaned_link = remove_affiliate_tag(url)
    "#{cleaned_link}&tag=#{new_tag}"
  end

  # works for amazon short affiliate url
  # we are assuming we copied short url from amazon.
  def self.already_has_our_affiliate?(url)
    url.match?(/amzn.to/)
  end

  def self.valid_uri?(uri)
    uri = URI.parse(uri)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def self.replace_query_param(url, param_name, new_param_value)
    uri = URI.parse(url)
    params = URI.decode_www_form(uri.query || '') << [param_name, new_param_value]
    uri.query = URI.encode_www_form(params.to_h)
    uri.to_s
  end
end
