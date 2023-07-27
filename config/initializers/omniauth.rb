# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['IG_APP_ID'], ENV['IG_APP_SECRET']
end
