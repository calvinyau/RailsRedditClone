Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]
  resources :subs, only: [:new, :create, :show, :index, :edit, :update]
  resources :posts, only: [:show, :new, :create, :edit, :update]
end
