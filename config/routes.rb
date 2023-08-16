# frozen_string_literal: true

Rails.application.routes.draw do
  get 'uploader/image'
  get 'fetch_url_info', controller: :application

  resources :links do
    member do
      patch :move
    end
    collection do
      get :manage
    end
  end
  get 'links/index'
  post 'uploader/image'

  default_url_options host: 'http://127.0.0.1:3000'

  # Defines the root path route ("/")
  root 'deals#index'

  get '/auth/instagram', to: 'instagram_auth#new', as: :new_instagram_auth
  get '/auth/instagram/callback', to: 'instagram_auth#create', as: :create_instagram_auth

  get '/auth/facebook/callback', to: 'facebook_auth#callback'
  get '/auth/facebook', to: 'facebook_auth#new', as: :new_facebook_auth
  get 'amazon-search', to: 'amazon_search#index'
  post 'amazon-search', to: 'amazon_search#build'

  resources :recurring_schedules, only: %i[new create edit update destroy]

  resources :posts
  resources :deals do
    member do
      post :upvote
      post :downvote
      patch :expire
      patch :renew
      post :create_link
      post :post_to_insta
      post :post_to_telegram
      get :add_images
      post :update_images
    end
  end

  resources :categories
  resources :stores do
    get 'search', on: :collection

    resources :referral_codes, only: %i[new create edit update destroy]
  end

  resolve('DealImages') { [:deal_images] }

  resource :deal_images, only: [:new] do
    collection do
      post :post_to_telegram
      post :post_to_insta
    end
  end
  get 'deal_images/update', to: 'deal_images#update'
  post 'deal_images/update', to: 'deal_images#update'

  # resources :deal_images do
  #   member do
  #     get :post_without_save
  #   end
  # end

  resources :social_media_posts do
    member do
      post :post_without_save
    end

    collection do
      post :create_insta_gallery
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

  # resources :users, only: :show
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
