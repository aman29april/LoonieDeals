# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load dotenv only in development or test environment
Dotenv::Railtie.load if %w[development test].include? Rails.env

ENV['SECRET_TOKEN_ENCRYPTION_KEY'] = '0b9ced199939c97dc457e33d0acefff7cd2f6988d58104474ef3cb9318e9acef'

module LoonieDeals
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.active_record.encryption.primary_key = ENV['PRIMARY_KEY']
    config.active_record.encryption.deterministic_key = ENV['DETERMINISTIC_KEY']
    config.active_record.encryption.key_derivation_salt = ENV['KEY_DERIVATION_SALT']

    config.action_view.form_with_generates_ids = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config.active_job.queue_adapter = :sidekiq

    config.assets.css_compressor = nil
  end
end
