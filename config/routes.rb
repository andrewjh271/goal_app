Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:new, :create, :index, :show]
  resource :user, only: [:destroy]
  resource :session
  resources :goals

  # resources :user_comments, only: [:create, :destroy]
  # resources :goal_comments, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
