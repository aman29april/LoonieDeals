# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy historic]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
    @data = @quote.monthly_prices.map do |mp|
      # {x: mp.date , y: mp.last_day_close_cents}
      [mp.date, mp.last_day_close_cents]
    end.to_json

    @data_keys = %w[
      January
      February
      March
      April
      May
      June
    ]
    @data_values = [0, 10, 5, 2, 20, 30, 45]
  end

  def historic
    params[:days]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quote_params
    params.fetch(:quote, {})
  end
end
