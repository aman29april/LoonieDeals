# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'links/new', type: :view do
  before(:each) do
    assign(:link, Link.new)
  end

  it 'renders new link form' do
    render

    assert_select 'form[action=?][method=?]', links_path, 'post' do
    end
  end
end
