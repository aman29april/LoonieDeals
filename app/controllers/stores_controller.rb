class StoresController < ApplicationController

  before_action :set_store, only: [:show]


  def index
    @stores = Store.by_deals
  end

  def show
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
end
