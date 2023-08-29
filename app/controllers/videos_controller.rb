# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_deal, :set_video

  def index; end

  def set_deal
    @deal = Deal.friendly.find(params[:deal_id])
  end

  def set_video
    @video = Video.new(@deal)
  end

  def post_to_telegram
    TelegramService.new.send_video(*@video.telegram_data)
    redirect_to action: :index, notice: 'Posted to telegram!'
  end

  def post_to_insta
    InstagramService.new.send_video(*@video.insta_data)
    redirect_to action: :index, notice: 'Posted to Instagram!'
  end
end
