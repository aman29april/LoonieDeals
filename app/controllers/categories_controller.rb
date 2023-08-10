# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Categories', :categories_path

  def index
    @categories = Category.by_deals
  end

  def show
    add_breadcrumb @category.parent.name, @category.parent if @category.parent.present?
    add_breadcrumb @category.name, @category
    @deals = @category.deals.active_first.recent.with_attached_image

    @side_bar = SideBar.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def search
    query = params[:q]
    category = Category.where('name ILIKE ?', "%#{query}%").limit(10)

    render json: category.map { |_category| { id: store.id, text: store.name } }
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id, :subcategory_ids)
  end
end
