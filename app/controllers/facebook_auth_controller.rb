# frozen_string_literal: true

class FacebookAuthController < ApplicationController
  def new
    redirect_to facebook_login_url, allow_other_host: true
  end

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

  def callback
    oauth = Koala::Facebook::OAuth.new
    access_token = oauth.get_access_token(params[:code])
    # short_lived_token = params[:access_token]
    long_lived_token = exchange_for_long_lived_token(access_token)

    # access_token = auth.credentials.token
    if long_lived_token.present?
      SiteSetting.instance.update!(facebook_access_token: long_lived_token)
      redirect_to root_path, notice: 'Connected to Facebook!'
    else
      redirect_to root_path, alert: 'Failed to connect to Facebook.'
    end
  end

  def exchange_for_long_lived_token(short_lived_token)
    long_lived_token_info = Koala::Facebook::OAuth.new.exchange_access_token_info(short_lived_token)

    return unless (long_lived_token_info['expires_in']).positive?

    long_lived_token_info['access_token']
  end

  # def exchange_for_long_lived_token(code)
  #   url = 'https://graph.facebook.com/oauth/access_token'
  #   params = {
  #     client_id: facebook_client_id,
  #     client_secret: facebook_client_secret,
  #     grant_type: 'fb_exchange_token',
  #     fb_exchange_token: code,
  #   }

  #   response = HTTParty.get(url, query: params)
  #   if response.success?
  #     parsed_response = CGI.parse(response.body)
  #     parsed_response['access_token'].first
  #   else
  #     nil
  #   end
  # end

  def facebook_login_url
    oauth = Koala::Facebook::OAuth.new
    redirect_uri = "#{request.base_url}/auth/facebook/callback/"

    # Replace 'email' with any additional permissions you need
    # permissions = ['email']
    permissions = SCOPES
    oauth.url_for_oauth_code(permissions:, redirect_uri:)
  end

  def koala_instance
    Koala::Facebook::OAuth.new
  end
end
