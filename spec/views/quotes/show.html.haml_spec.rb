# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/show', type: :view do
  before(:each) do
    assign(:quote, Quote.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
