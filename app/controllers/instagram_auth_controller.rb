# frozen_string_literal: true

# app/controllers/instagram_auth_controller.rb
class InstagramAuthController < ApplicationController
  SCOPES = %w[
    publish_video
    catalog_management
    pages_manage_instant_articles
    pages_show_list
    read_page_mailboxes
    business_management
    pages_messaging
    instagram_basic
    instagram_manage_comments
    instagram_manage_insights
    instagram_content_publish
    instagram_manage_messages
    page_events
    pages_read_engagement
    pages_manage_metadata
    pages_read_user_content
    pages_manage_posts
    pages_manage_engagement
  ].freeze

  def new
    redirect_to instagram_authorize_url, allow_other_host: true
  end

  def create
    response = retrieve_access_token(params[:code])
    if response['access_token'].present?
      current_user.update(instagram_access_token: response['access_token'])
      redirect_to root_path, notice: 'Connected to Instagram!'
    else
      redirect_to root_path, alert: 'Failed to connect to Instagram.'
    end
  end

  private

  def instagram_authorize_url
    # "https://api.instagram.com/oauth/authorize?client_id=#{client_id}&redirect_uri=#{instagram_redirect_uri}&response_type=code"

    # "https://graph.facebook.com/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials"

    "https://graph.facebook.com/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials&redirect_uri=#{redirect_url}&scope=#{SCOPES.join(',')}"
  end

  def retrieve_access_token(code)
    url = 'https://api.instagram.com/oauth/access_token'
    payload = {
      client_id: instagram_client_id,
      client_secret: instagram_client_secret,
      grant_type: 'authorization_code',
      redirect_uri: instagram_redirect_uri,
      code:
    }

    response = HTTParty.post(url, body: payload)
    response.parsed_response
  end

  def client_id
    ENV['IG_APP_ID']
  end

  def client_secret
    ENV['IG_APP_SECRET']
  end

  def redirect_url
    ENV['IG_REDIRECT_URL']
  end
end
