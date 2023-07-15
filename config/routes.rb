# frozen_string_literal: true

Rails.application.routes.draw do
  get 'links/index'

  default_url_options :host => "http://127.0.0.1:3000"

  # Defines the root path route ("/")
  root 'home#index'

  resources :deals do
    member do
      post :upvote
      post :downvote
    end
  end

  resources :stores do
    get 'search', on: :collection
  end

  get 'links', to: 'links#index'



  resources :links, only: %i[index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
