# frozen_string_literal: true

Rails.application.routes.draw do
  resources :customer_requests, only: %i[new create]
  resources :sessions, only: %i[create new]
  delete :sessions, to: 'sessions#destroy'
  root 'customer_requests#new'
end
