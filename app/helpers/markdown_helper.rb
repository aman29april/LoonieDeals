# frozen_string_literal: true

module MarkdownHelper
  def markdown_link(link_text, url, title = nil)
    if title
      "[#{link_text}](#{url} '#{title}')"
    else
      "[#{link_text}](#{url})"
    end
  end

  # define methods md_bold, md_italics, md_monospaced, md_strikethrough
  {
    bold: '**',
    italics: '__',
    monospaced: '```',
    strikethrough: '~~'
  }.each do |key, value|
    define_method "md_#{key}" do |text|
      [value, text, value].join('')
    end
  end

  # def monospaced(text)
  #   "```#{text}```"
  # end

  # def md_bold(text)
  #   "**#{text}**"
  # end

  # def md_italics(text)
  #   "__#{text}__"
  # end
end
