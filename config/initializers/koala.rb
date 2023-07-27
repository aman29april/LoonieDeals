# frozen_string_literal: true

Koala.configure do |config|
  config.access_token = ENV['IG_ACCESS_TOKEN']
  config.app_access_token = ENV['IG_APP_ACCESS_TOKEN']
  config.app_id = ENV['IG_APP_ID']
  config.app_secret = ENV['IG_APP_SECRET']
  config.oauth_callback_url = ENV['FB_CALLBACK_URI']
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
