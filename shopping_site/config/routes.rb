Rails.application.routes.draw do
  get 'users_session/new'
  post 'users_session/create'
  get 'users_session/destroy'
  resources :users
  get 'admins_session/new'
  post'admins_session/create'
  get 'session/new'
  root 'static#home'
  get 'static/home'
  
  resources :carts, only: [:create, :index, :destroy]
  resources :admins
  resources :items
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
