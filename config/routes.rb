Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :users
  resources :cars, only: [:new, :create, :edit, :update, :destroy]

  resources :cleanings
  root 'pages#home'
  get '/dashboard', to: 'users#show'
  get '/dashboard/edit', to: 'users#edit'

  resources :orders, only: [:show, :create]

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
#page statique about
  get "/:page" => "static#show"

end
