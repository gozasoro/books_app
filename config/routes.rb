# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
  }
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "books#index"
end
