# frozen_string_literal: true

class SessionsController < ApplicationController
  def facebook_login
    redirect_uri = 'YOUR_REDIRECT_URI'
    scopes = 'public_profile,email' # Adjust the scopes as needed
    facebook_login_url = Koala::Facebook::OAuth.new.get_authorization_url(redirect_uri:, scope: scopes)

    redirect_to facebook_login_url
  end

  def facebook_callback
    # Retrieve the authorization code from the callback request parameters
    authorization_code = params[:code]

    # Exchange the authorization code for an access token
    redirect_uri = ''
    app_id = ENV['IG_APP_ID']
    app_secret = ENV['IG_APP_SECRET']

    oauth = new(app_id, app_secret, redirect_uri)
    oauth.get_access_token(authorization_code)

    # Save and manage the access token securely
    # ...

    redirect_to root_path
  end
end
