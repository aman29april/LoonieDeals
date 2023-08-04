# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials.instagram.app_id, Rails.application.credentials.instagram.app_secret
end
