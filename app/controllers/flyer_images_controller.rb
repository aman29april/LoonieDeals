# frozen_string_literal: true

class FlyerImagesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_deal, :set_flyer_image

  def index; end

  def create
    @flyer_image.assign_attributes(flyer_deal_params)
    @flyer_image.generate!

    render :show
  end

  def post_to_telegram
    TelegramService.new.send_photos(*@flyer_image.telegram_data)
    # respond_to do |format|
    #   format.html { redirect_to action: :index, notice: "Player was successfully created." }
    #   format.turbo_stream { flash.now[:notice] = "Quote was successfully destroyed." }

    # end
    redirect_to action: :index, notice: 'Posted to telegram!'
  end

  def post_to_insta
    InstagramService.new.create_photo_post(*@flyer_image.insta_data)
    redirect_to action: :index, notice: 'Posted to Instagram!'
  end

  def attach
    @deal.purge_generated_flyer_images
    @flyer_image.photo_urls.each_with_index do |image, index|
      @deal.generated_flyer_images.attach(io: File.open(image), filename: "flyer_#{index}")
    end
    @deal.save!
    redirect_to action: :index, notice: 'Images attached on deal'
  end

  def generate_video
    VideoService.create_video(*@flyer_image.video_data)
    redirect_to action: :index, notice: 'Video created'
  end

  private

  def set_flyer_image
    @flyer_image = FlyerImage.new(@deal)
  end

  def set_deal
    @deal = Deal.friendly.find(params[:deal_id])
  end

  def flyer_deal_params
    params.require(:flyer_image).permit(:title, :enlarge_image_by, :type, :extra,
                                        :theme, :hash_tags, :hide_store, :enlarge_logo_by, :image_offset)
  end
end
