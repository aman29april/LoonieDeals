# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuotePrice, type: :model do
  context 'validations' do
    it 'is valid with a quote_id, date and price' do
      quote = Quote.create(name: 'AAPL')
      quote_price = QuotePrice.new(quote_id: quote.id, date: Date.today, price: 200.50)
      expect(quote_price).to be_valid
    end

    it 'is invalid without a quote_id' do
      quote_price = QuotePrice.new(date: Date.today, price: 200.50)
      expect(quote_price).to_not be_valid
    end

    it 'is invalid without a date' do
      quote = Quote.create(name: 'AAPL')
      quote_price = QuotePrice.new(quote_id: quote.id, price: 200.50)
      expect(quote_price).to_not be_valid
    end

    it 'is invalid without a price' do
      quote = Quote.create(name: 'AAPL')
      quote_price = QuotePrice.new(quote_id: quote.id, date: Date.today)
      expect(quote_price).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a quote' do
      quote_price = QuotePrice.reflect_on_association(:quote)
      expect(quote_price.macro).to eq(:belongs_to)
    end
  end
end
