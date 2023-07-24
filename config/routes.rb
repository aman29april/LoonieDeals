# frozen_string_literal: true

Rails.application.routes.draw do
  get 'fetch_url_title', controller: :application

  resources :links do
    member do
      patch :move
    end
    collection do
      get :manage
    end
  end
  get 'links/index'

  default_url_options host: 'http://127.0.0.1:3000'

  # Defines the root path route ("/")
  root 'home#index'

  resources :deals do
    member do
      post :upvote
      post :downvote
      patch :expire
      post :create_link
    end
  end

  resources :stores do
    get 'search', on: :collection
  end

  resources :social_media_posts do
    member do
      post :post_without_save
    end
  end

  resources :tags, only: [:show]

  get 'links', to: 'links#index'

  resources :links, only: %i[index]
  resources :site_settings, only: %i[edit update]

  get '/facebook_callback', to: 'sessions#facebook_callback', as: :facebook_callback,
                            constraints: { host: 'localhost', port: 3000 }

  # get 'post_deal/:deal_id', to: 'social_media#index', as: 'post_deal'
  # post 'post_deal/:deal_id', to: 'social_media#create', as: 'create_post_deal'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
