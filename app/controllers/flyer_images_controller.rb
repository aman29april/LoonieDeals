# frozen_string_literal: true

class FlyerImagesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_deal, :set_flyer_deal

  def index; end

  def create
    @flyer_deal.assign_attributes(flyer_deal_params)
  end

  def post_to_telegram
    TelegramService.new.send_photos(*@flyer_deal.telegram_data)
    # respond_to do |format|
    #   format.html { redirect_to action: :index, notice: "Player was successfully created." }
    #   format.turbo_stream { flash.now[:notice] = "Quote was successfully destroyed." }

    # end
    redirect_to action: :index, notice: 'Posted to telegram!'
  end

  def post_to_insta
    InstagramService.new.create_photo_post(*@flyer_deal.insta_data)
    redirect_to action: :index, notice: 'Posted to Instagram!'
  end

  def attach
    @flyer_deal.photo_urls.each_with_index do |image, index|
      @deal.generated_flyer_images.attach(io: File.open(image), filename: "flyer_#{index}")
    end
    @deal.save!
    redirect_to action: :index, notice: 'Images attached on deal'
  end

  private

  def set_flyer_deal
    @flyer_deal = FlyerDeal.new(@deal)
  end

  def set_deal
    @deal = Deal.friendly.find(params[:deal_id])
  end

  def flyer_deal_params
    params.permit(:title, :enlarge_image_by, :type,
                  :theme, :hash_tags, :hide_store, :enlarge_logo_by, :image_offset)
  end
end
