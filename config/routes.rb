Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'pages#home'
  get "/about" => "pages#show"
  resources :users, only: [:index]

  namespace :client do
    resources :cleanings, only: [:new, :create, :edit, :show, :update, :destroy]
    resources :users, only: [:edit, :show, :update, :destroy]
    get '/dashboard', to: 'users#show'
    get '/dashboard/edit', to: 'users#edit'
    resources :cars
    resources :orders, only: [:show] do
      resources :payments, only: [:new, :create]
    end
  end

  namespace :pro do
    resources :users, only: [:show, :edit, :update]
    get '/dashboard', to: 'users#show'
    get '/dashboard/edit', to: 'users#edit'
    resources :cleanings, only: [:edit, :show, :update, :destroy]
  end

  mount Attachinary::Engine => "/attachinary"
end
