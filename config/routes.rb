Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy]
  end

  get :invite, to: "users#invite", as: 'invite'
  get "accept/:id", to: "users#accept", as: 'accept'
  delete "reject/:id", to: "users#reject", as: 'reject'
end
