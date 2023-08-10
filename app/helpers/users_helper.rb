# frozen_string_literal: true

module UsersHelper
  def avatar_for(user, options = { size: 80 })
    return ''
    size = options[:size]
    style = options[:style]
    img = if user.avatar? && size <= 80
            user.avatar.url(:thumb)
          elsif user.avatar?
            user.avatar.url
          elsif user.respond_to?(:image_url) && user.image_url.present?
            user.image_url
          else
            user.class.default_avatar
          end
    image_tag img, width: size, height: size, class: 'avatar-image', style:
  end
end
