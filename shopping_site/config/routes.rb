Rails.application.routes.draw do
  get 'orders_admin/index'
  get 'orders_admin/show'
  patch 'orders_admin/update'
  get 'users_session/new'
  post 'users_session/create'
  get 'users_session/destroy'
  resources :users
  get 'admins_session/new'
  post'admins_session/create'
  get 'admins_session/destroy'
  get 'session/new'
  root 'static#home'
  get 'static/home'
  get 'orders/create'
  
  
  resources :carts, only: [:create, :index, :destroy]
  resources :admins
  resources :items
  resources :orders, only: [:show, :new]
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
