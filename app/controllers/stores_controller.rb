# frozen_string_literal: true

class StoresController < ApplicationController
  before_action :set_store, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[edit update]

  def index
    @stores = if params[:q].present?
                Store.where('name LIKE ?', "%#{params[:q]}%")
              else
                Store.by_deals
              end
  end

  def show
    @deals = @store.deals.includes(:store)
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
    params.require(:store).permit(:name, :description, :website, :image, :featured, :affiliate_id)
  end
end
