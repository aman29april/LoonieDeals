# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CateogriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/cateogries').to route_to('cateogries#index')
    end

    it 'routes to #new' do
      expect(get: '/cateogries/new').to route_to('cateogries#new')
    end

    it 'routes to #show' do
      expect(get: '/cateogries/1').to route_to('cateogries#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/cateogries/1/edit').to route_to('cateogries#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/cateogries').to route_to('cateogries#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/cateogries/1').to route_to('cateogries#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/cateogries/1').to route_to('cateogries#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/cateogries/1').to route_to('cateogries#destroy', id: '1')
    end
  end
end
