# frozen_string_literal: true

Rails.application.routes.draw do
  resources :quotes do
    get :historic, format: :json
  end

  # resource :sharks, only: [:index]

  # get 'sharks', controller: 'sharks', action: 'index', as: 'sharks'

  resources :sharks, only: %i[index show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'application#index'
end
