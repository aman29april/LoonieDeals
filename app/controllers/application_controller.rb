# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?, :is_admin?


  def index; end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def is_admin?
    signed_in? ? current_user.admin : false
  end
end
