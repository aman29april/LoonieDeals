# frozen_string_literal: true

module LinksHelper
  def remove_affiliate_tag(url)
    affiliate_tag_regex = /(?:\?|&)tag=[^&]+/
    url.gsub(affiliate_tag_regex, '')
  end

  def replace_affiliate_tag(url, new_tag)
    cleaned_link = remove_affiliate_tag(url)
    "#{cleaned_link}&tag=#{new_tag}"
  end
end
