Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :users, only: [:index, :show]
  resources :cars, only: [:new, :create, :edit, :update, :destroy]

  resources :cleanings
  root 'pages#home'
  get '/dashboard', to: 'users#show'

#page statique about
  get "/:page" => "static#show"
end
