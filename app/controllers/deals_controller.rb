# frozen_string_literal: true

class DealsController < ApplicationController
  include ActiveStorage::SetCurrent
  include Pagy::Backend

  before_action :authenticate_user!, except: %i[show index]
  before_action :set_deal, only: %i[show edit update destroy expire create_link post_to_insta post_to_telegram renew add_images update_images]
  before_action :set_deal_image, only: %i[post_to_insta post_to_telegram]

  def index
    search = "%#{params[:q]}%"
    @deals = if params[:q].present?
               Deal.where('title LIKE ? or short_slug LIKE ?', search, search)
             else
               Deal.all.includes(:store)
             end

    @pagy, @deals = pagy(@deals.active_first.recent.with_attached_image.with_store)
    @side_bar = SideBar.new
  end

  def show
    add_breadcrumb 'Home', :root_path
    add_breadcrumb @deal.store.name, @deal.store
    # add_breadcrumb @deal.category.name, @deal.category

    @deal.increment!(:view_count)
    @side_bar = SideBar.new(current_deal: @deal)
  end

  def new
    @deal = Deal.new(new_deal_params)
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

  def renew
    @deal.renew!
    redirect_to @deal, notice: 'Deal has been renewed.'
  end

  def add_images

  end

  def update_images
    params.require(:deal).permit(:secondary_images)
    secondary_images = params[:deal][:secondary_images].compact
    p = {secondary_images: secondary_images}
    @deal.assign_attributes(p)

    if @deal.save
      redirect_to @deal, notice: 'Deal image successfully added.'
    else
      render :add_images, flash: { error: 'Error in adding images' }
    end
  end

  private

  def set_deal
    @deal = Deal.friendly.find(params[:id])
  end

  def set_deal_image
    @deal_image = DealImage.new(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title, :description, :price, :retail_price, :discount, :expiration_date, :url, :auto_create_link, :large_image, :secondary_images, :weekly_flyer_deal,
                                 :pinned, :image, :store_id, :category_ids, :meta_keywords, :meta_description, :body, :all_tags, :coupon, :generated_image, :image_full_with, :store_background, :hide_discount, :enlarge_image_by, :hide_coupon)
  end

  def new_deal_params
    p = {}
    return p if params[:weekly_flyer_deal] != 'true'
    if params[:category].present?
      category = Category.where("LOWER(name) like ?", "%#{params[:category].downcase}%").first
      p[:category_ids] = [category.id] if category.present?
    end
    p.merge!({
      title: 'Weekly picks',
      expiration_date: DateUtil.end_of_next_wednesday,
      weekly_flyer_deal: true,
    })
    p
  end
end
