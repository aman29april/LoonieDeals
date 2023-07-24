# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'links/index', type: :view do
  before(:each) do
    assign(:links, [
             Link.create!,
             Link.create!
           ])
  end

  it 'renders a list of links' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
