Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "orders#new"
  resources :orders
  resources :items, only: [:new, :create, :index, :destroy]
  resources :discounts, only: [:new, :create, :index, :destroy]
end
