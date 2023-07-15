class DealsController < ApplicationController
  include ActiveStorage::SetCurrent
  # before_action :authenticate_user!, except: [:show, :index]
  before_action :set_deal, only: %i[show edit update destroy]

  def index
    
    @deals = Deal.all
  end

  def show
    @deal.increment!(:view_count)
  end

  def new
    @deal = Deal.new
    @stores = Store.all
    @categories = Category.all
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      redirect_to @deal, notice: 'Deal was successfully created.'
    else
      flash.now[:alert] = 'Could not update the deal, Please try again'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @deal.update(deal_params)
      redirect_to @deal, notice: 'Deal was successfully updated.'
    else
      render :edit
    end
  end

  def upvote
    @deal = Deal.find(params[:id])
    @deal.upvote
    respond_to :js
  end

  def downvote
    @deal = Deal.find(params[:id])
    @deal.downvote
    respond_to :js
  end

  def destroy
    @deal.destroy
    redirect_to deals_url, notice: 'Deal was successfully destroyed.'
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title, :description, :price, :retail_price, :discount, :expiration_date, :url, :pinned, :image, :store_id, :category_id, :meta_keywords, :meta_description, :body, :all_tags )
  end
end
