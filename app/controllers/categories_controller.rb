# frozen_string_literal: true

class CategoriesController
end

class CategoryController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @category = Category.by_deals
  end

  def show; end

  def search
    query = params[:q]
    category = Category.where('name ILIKE ?', "%#{query}%").limit(10)

    render json: category.map { |_category| { id: store.id, text: store.name } }
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
