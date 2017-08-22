Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:index, :show], shallow: true do
    resources :cars, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :cleanings
  post 'to-cleaner', to: "users#change_to_cleaner"
  root 'pages#home'
end
