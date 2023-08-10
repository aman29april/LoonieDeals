# frozen_string_literal: true

class SocialMediaPostsController < ApplicationController
  # include ActionView::Helpers
  helper ApplicationHelper

  before_action :set_data
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update]

  def new
    @social_media_post = SocialMediaPost.new(deal: @deal, text: @deal&.text_with_url)
  end

  def show; end

  def create
    @social_media_post = SocialMediaPost.new(post_deal_params)

    return post_to_instagram if params[:post_to_instagram]

    if params[:action] != 'post_and_save'
      flash[:success] = 'Deal successfully posted on selected social media accounts.'
      return render :new
    end

    return unless params[:action] == 'post_and_save'

    if @social_media_post.save
      flash[:success] = 'Deal successfully posted on selected social media accounts.'
      redirect_to @social_media_post
    else
      flash.now[:alert] = 'Could not update, Please try again'
      render :new, status: :unprocessable_entity
    end
  end

  def post_without_save
    @social_media_post = SocialMediaPost.new(post_deal_params)
    image_url = resource_image_url(@social_media_post.self_or_deal_image)
    caption = @social_media_post.text
    InstagramService.new.create_photo_post(image_url, caption:)
  end

  def post_to_instagram
    if @social_media_post.images.blank?
      flash.now[:alert] = 'No Photos'
      return render :new, status: :unprocessable_entity
    end

    service = InstagramService.new

    service.create_photo_post(*@social_media_post.insta_data)
    flash.now[:notice] = 'Post gallery sent!'
    render :new
  end

  def insta_gallery; end

  # def create_insta_gallery

  # end

  def edit; end

  def update
    if @social_media_post.update(post_deal_params)
      redirect_to @social_media_post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_data
    @deal = Deal.friendly.find(params[:deal]) if params[:deal]

    @all_accounts = [
      { platform: 'facebook', name: 'Facebook Account' },
      { platform: 'instagram', name: 'Instagram Account' },
      { platform: 'twitter', name: 'Twitter Account' }
    ]
  end

  def set_post
    @social_media_post = SocialMediaPost.find(params[:id])
  end

  def post_deal_params
    params.require(:social_media_post).permit(:deal_id, :text, :scheduled_at, social_media_accounts: [], images: [])
  end
end
