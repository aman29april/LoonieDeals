# frozen_string_literal: true

class DealImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only: %i[new show update post_to_telegram]
  config.cache_store = :null_store

  def new
    render :update
  end

  def show; end

  def update
    @deal_image.assign_attributes(deal_params)
    @deal_image.generate!

    post_to_telegram if params[:post_to_telegram]
    post_to_insta if params[:post_to_insta]

    render :show
  end

  def post_to_telegram
    # debugger
    TelegramService.new.send_photo(*@deal_image.telegram_data)
    flash.now[:notice] = 'Message sent!'
    # render :update
  end

  def post_to_insta
    InstagramService.new.send_photo(*@deal_image.insta_data)
    flash.now[:notice] = 'Post sent!'
    render :update
  end

  private

  def set_data
    @deal_image = DealImage.new(params)
  end

  def deal_params
    params.permit(:title, :image_full_with, :store_background, :hide_discount, :enlarge_image_by, :hide_coupon, :type,
                  :url, :coupon, :extra, :hide_deal_image, :hide_store_logo)
  end
end
