# frozen_string_literal: true

module ShortIdUtil
  def self.generate_short_slug(model = Deal)
    # charset = [('a'..'z'), (0..9)].map(&:to_a).flatten
    charset = [('a'..'z')].map(&:to_a).flatten
    loop do
      short_slug = Array.new(3) { charset.sample }.join
      break short_slug unless model.exists?(short_slug:)
    end
  end
end
