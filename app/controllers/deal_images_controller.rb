# frozen_string_literal: true

class DealImagesController < ApplicationController
  helper ApplicationHelper

  before_action :set_data
  before_action :authenticate_user!

  def new
    ImageGenerationService.new(@deal).generate
    render :update
  end

  def show
  end

  def update
    @deal.assign_attributes(deal_params)
    flash.now[:notice] = ImageGenerationService.new(@deal).generate

    render :show
  end

  private

  def set_data
    @deal = Deal.find(params[:deal])
  end

   def deal_params
    params.permit(:title, :image_full_with, :store_background, :hide_discount, :enlarge_image_by, :hide_coupon)
  end
end
