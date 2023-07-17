# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show historic]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
    prices =  []
    volumes = []
    @quote.monthly_prices.map do |mp|
      prices << [mp.date, mp.last_day_close_cents]
      volumes << [mp.date, mp.volume]
    end

    @data = {
      datasets: [
        {
          metric: 'Price',
          label: 'Price',
          values: prices,
          meta: {
            unit: 'month',
            exchange: ''
          }
        },
        {
          metric: 'Volume',
          label: 'Volume',
          values: volumes,
          meta: {}
        }
      ]
    }.to_json

    @options = { view: params[:view] }
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
