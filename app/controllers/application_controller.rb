# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :is_admin?
  helper_method :current_user?

  def redirect
    params[:url]
  end

  def index; end

  def is_admin?
    user_signed_in?
    # ? current_user.admin : false
  end

  def current_user?(user)
    current_user.id == user.id
  end

  def fetch_url_info
    link_url = params[:link_url]
    return nil if link_url.blank?

    begin
      data = ScrapWebPageService.new(link_url).data

      render json: data
    rescue StandardError => e
      Rails.logger.error "Error fetching title from link: #{e.message}"
      head :bad_request
    end
  end
end
