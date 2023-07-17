# frozen_string_literal: true

class SocialMediaPostsController < ApplicationController
  before_action :set_data
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update]

  def new
    @social_media_post = SocialMediaPost.new(text: @deal&.text_with_url)
  end

  def show; end

  def create
    @social_media_post = SocialMediaPost.new(post_deal_params)
    if @social_media_post.save
      flash[:success] = 'Deal successfully posted on selected social media accounts.'
      redirect_to @social_media_post
    else
      flash.now[:alert] = 'Could not update, Please try again'
      render :new, status: :unprocessable_entity
    end
  end

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
    @deal = Deal.where(id: params[:deal]).last

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
    params.require(:social_media_post).permit(:deal_id, :text, :scheduled_at, social_media_accounts: [])
  end
end
