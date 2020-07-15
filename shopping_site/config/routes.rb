Rails.application.routes.draw do
  get 'admins_session/new'
  post'admins_session/create'
  get 'session/new'
  root 'static#home'
  get 'static/home'
  
  resources :admins
  resources :items
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
