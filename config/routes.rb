# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions, only: %i[create new]
  delete :sessions, to: 'sessions#destroy'
end
