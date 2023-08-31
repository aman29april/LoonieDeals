# frozen_string_literal: true

class StoresController < ApplicationController
  before_action :set_store, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[edit update]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Stores', :stores_path

  def index
    @stores = if params[:q].present?
                Store.where('name LIKE ?', "%#{params[:q]}%").with_attached_image
              else
                @top_stores = Store.by_deals.with_attached_image.limit(16)
                Store.by_deals.with_attached_image
              end
  end

  def show
    add_breadcrumb @store.name, @store
    @deals = @store.deals.active_first.recent.with_attached_image

    @expired_deals = @store.deals.with_attached_image.expired.recent.limit(4)
    @side_bar = SideBar.new
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)

    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
    else
      flash.now[:alert] = 'Could not update the Store, Please try again'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @store.update(store_params)
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render :edit
    end
  end

  def search
    query = params[:q]
    stores = Store.where('name ILIKE ?', "%#{query}%").limit(10)

    render json: stores.map { |store| { id: store.id, text: store.name } }
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :description, :website, :image, :featured, :affiliate_id, :referral,
                                  category_ids: [])
  end
end
