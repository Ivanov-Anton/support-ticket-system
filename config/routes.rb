# frozen_string_literal: true

Rails.application.routes.draw do
  resources :admin_customer_requests, only: %i[show destroy update]
  get 'admin', to: 'admin_customer_requests#index'

  resources :customer_requests, only: %i[new create]
  resources :sessions, only: %i[create new]
  delete :sessions, to: 'sessions#destroy'
  root 'customer_requests#new'

  resources :admin_comments, only: %i[create new destroy]
end
