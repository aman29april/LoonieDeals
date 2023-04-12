# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/edit', type: :view do
  let(:quote) do
    Quote.create!
  end

  before(:each) do
    assign(:quote, quote)
  end

  it 'renders the edit quote form' do
    render

    assert_select 'form[action=?][method=?]', quote_path(quote), 'post' do
    end
  end
end
