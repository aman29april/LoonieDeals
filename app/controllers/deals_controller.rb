# frozen_string_literal: true

class DealsController < ApplicationController
  include ActiveStorage::SetCurrent
  include Pagy::Backend

  before_action :authenticate_user!, except: %i[show index]
  before_action :set_deal, only: %i[show edit update destroy expire create_link post_to_insta post_to_telegram]
  before_action :set_deal_image, only: %i[post_to_insta post_to_telegram]

  def index
    search = "%#{params[:q]}%"
    @deals = if params[:q].present?
               Deal.where('title LIKE ? or short_slug LIKE ?', search, search)
             else
               Deal.all.includes(:store)
             end

    @pagy, @deals = pagy(@deals.active_first.recent.with_attached_image.with_store)
  end

  def show
    @deal.increment!(:view_count)
  end

  def new
    @deal = Deal.new
    @stores = Store.all.by_name
    @categories = Category.all.by_name
  end

  def create
    @deal = Deal.new(deal_params)

    return generate_image if params[:generate_image]

    if @deal.save
      redirect_to @deal, notice: 'Deal was successfully created.'
    else
      flash.now[:alert] = 'Could not update the deal, Please try again'
      render :new, status: :unprocessable_entity
    end
  end

  def generate_image
    path = ImageGenerationService.new(@deal).generate
    flash.now[:alert] = path
    @deal.generated_image = path
    render @deal.persisted? ? :edit : :new
  end

  def post_to_insta; end

  def post_to_telegram
    TelegramService.new.send_photo(*@deal_image.telegram_data)
    redirect_to @deal, notice: 'Posted to telegram!'
  end

  def post_to_insta
    InstagramService.new.send_photo(*@deal_image.insta_data)
    redirect_to @deal, notice: 'Posted to Instagram!'
  end

  def edit; end

  def update
    @deal.assign_attributes(deal_params)
    return generate_image if params[:generate_image]
    return post_to_telegram if params[:post_to_telegram]

    if @deal.save
      redirect_to @deal, notice: 'Deal was successfully updated.'
    else
      render :edit
    end
  end

  def create_link
    if @deal.link.present?
      redirect_back_or_to @deal, flash: { error: 'Link already exist' }
    elsif @deal.valid?(:create_link) && Link.create_from(@deal)
      redirect_to @deal, notice: 'Link Created successfully.'
    else
      redirect_back_or_to @deal, notice: 'something went wrong'
    end
  end

  def upvote
    @deal = Deal.friendly.find(params[:id])
    @deal.upvote
    respond_to :js
  end

  def downvote
    @deal = Deal.friendly.find(params[:id])
    @deal.downvote
    respond_to :js
  end

  def destroy
    @deal.destroy
    redirect_to deals_url, notice: 'Deal was successfully destroyed.'
  end

  def expire
    @deal.expire!
    redirect_to @deal, notice: 'Deal has been expired.'
  end

  private

  def set_deal
    @deal = Deal.friendly.find(params[:id])
  end

  def set_deal_image
    @deal_image = DealImage.new(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title, :description, :price, :retail_price, :discount, :expiration_date, :url,
                                 :pinned, :image, :store_id, :category_id, :meta_keywords, :meta_description, :body, :all_tags, :coupon, :generated_image, :image_full_with, :store_background, :hide_discount, :enlarge_image_by, :hide_coupon)
  end
end
