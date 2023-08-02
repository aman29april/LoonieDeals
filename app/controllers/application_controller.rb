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

  def fetch_url_title
    link_url = params[:link_url]
    return nil if link_url.blank?

    begin
      Net::HTTP.get_response(URI.parse(link_url(link_url)))
      page = Nokogiri::HTML(ScrapWebPageService.get_html_content)
      # title = page.title.strip
      title = page.at_css('title').text
      render plain: title
    rescue StandardError => e
      Rails.logger.error "Error fetching title from link: #{e.message}"
      head :bad_request
    end

    # title
  end
end
