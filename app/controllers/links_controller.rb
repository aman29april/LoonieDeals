# frozen_string_literal: true

class LinksController < ApplicationController
  layout 'linktree', only: :index
  include Pagy::Backend

  before_action :set_link, only: %i[show edit update destroy move]
  before_action :authenticate_user!, except: %i[index]

  # GET /links or /links.json
  def index
    @pinned = Link.pinned.by_position

    @links = if params[:q].present?
               Link.where('short_slug LIKE ?', "%#{params[:q]}%")
             else
               Link.un_pinned.by_position
             end

    @pagy, @links = pagy(@links)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /links/1 or /links/1.json
  def show; end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  def manage
    @links = Link.all.by_position
  end

  def move
    @link.insert_at(params[:position].to_i)
    head :ok
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to manage_links_url, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:label, :image, :url, :pinned, :position, :enabled)
  end
end
