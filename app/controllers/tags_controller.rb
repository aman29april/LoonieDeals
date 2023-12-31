# frozen_string_literal: true

class TagsController < ApplicationController
  include Pagy::Backend
  before_action :set_tag

  def show
    @dashboard = Dashboard.new(deals: tagged_deals, tag: @tag, user: current_user)
    @related_tags = @tag.related_tags
    set_meta_tags @tag.meta_info
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tagged_deals
    @deals = Deal.tagged_with(@tag.name).order(created_at: :desc)

    @pagy, @tagged_deals = pagy(@deals.with_attached_image.with_store)
  end
end
