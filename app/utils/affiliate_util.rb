# frozen_string_literal: true

module AffiliateUtil
  def self.remove_affiliate_tag(url)
    affiliate_tag_regex = /(?:\?|&)tag=[^&]+/
    url.gsub(affiliate_tag_regex, '')
  end

  def self.replace_affiliate_tag(url, our_affiliate)
    return url if already_has_our_affiliate?(url, our_affiliate)

    # cleaned_link = remove_affiliate_tag(url)
    # "#{cleaned_link}&tag=#{our_affiliate}"
    UrlUtil.replace_query_param(url, 'tag', our_affiliate)
  end

  # works for amazon short affiliate url
  # we are assuming we copied short url from amazon.
  def self.already_has_our_affiliate?(url, our_affiliate)
    uri = URI.parse(url)
    params = URI.decode_www_form(uri.query || '')
    tag_value = URI.decode_www_form(uri.query || '').to_h['tag']

    tag_value == our_affiliate
  end
end
