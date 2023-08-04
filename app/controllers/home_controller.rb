# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @deals = if params[:q].present?
               Deal.where('title LIKE ?', "%#{params[:q]}%")
             else
               Deal.all.includes(:store).recent
             end

    @deals = @deals.page(params[:page])
  end
end
