Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :users, only: [:index, :show]
  resources :cars, only: [:new, :create, :edit, :update, :destroy]

  resources :cleanings
  root 'pages#home'
  get '/dashboard', to: 'users#show'

  resources :orders, only: [:show, :create]

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

end
