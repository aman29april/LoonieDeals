# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :is_admin?

  def redirect
    params[:url]
  end

  def index; end

  def is_admin?
    user_signed_in?
    # ? current_user.admin : false
  end
end
