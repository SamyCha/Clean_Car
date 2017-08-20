Rails.application.routes.draw do
  resources :users, only: [:index, :show, :update]

  get 'users/new'

  get 'users/show'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
