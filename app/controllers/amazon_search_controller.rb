# frozen_string_literal: true

class AmazonSearchController < ApplicationController
  def index; end

  def build
    uri = URI.parse('https://amazon.ca/s')
    query_params = {
      k: params[:keywords],
      s: params[:sort],
      i: params[:department]
    }.compact

    rh = []
    rh << "p_89:#{params[:brand]}" if params[:brand].present?
    rh << "p_75:#{discount_range}" if discount_range.present?
    rh << "p_74:#{price_range}" if price_range.present?
    rh << "p_72:#{params[:ratings]}" if params[:ratings].present?
    rh << 'p_85:5690392011' if params[:eligible_for_prime] == '1'
    rh << 'p_76:2308284011' if params[:eligible_for_free_shipping] == '1'
    rh << 'p_n_is_sns_available:8526117011' if params[:eligible_for_save_and_subs] == '1'

    query_params[:rh] = rh.join(',') if rh.present?

    uri.query = URI.encode_www_form(query_params)

    redirect_to uri.to_s, allow_other_host: true
  end

  def discount_range
    min = params[:min_pct_off]
    max = params[:max_pct_off]
    return if min.blank? && max.blank?

    "#{min}-#{max}"
  end

  def price_range
    min = params[:min_price]
    max = params[:max_price]
    return if min.blank? && max.blank?

    "#{min}-#{max}"
  end
end
