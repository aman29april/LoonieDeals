# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'links/edit', type: :view do
  let(:link) do
    Link.create!
  end

  before(:each) do
    assign(:link, link)
  end

  it 'renders the edit link form' do
    render

    assert_select 'form[action=?][method=?]', link_path(link), 'post' do
    end
  end
end
