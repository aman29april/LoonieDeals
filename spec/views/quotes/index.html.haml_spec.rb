# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes/index', type: :view do
  before(:each) do
    assign(:quotes, [
             Quote.create!,
             Quote.create!
           ])
  end

  it 'renders a list of quotes' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
