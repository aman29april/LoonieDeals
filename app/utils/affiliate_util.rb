# frozen_string_literal: true

module AffiliateUtil
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
end
