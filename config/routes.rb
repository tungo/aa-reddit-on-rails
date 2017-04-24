Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs
  resources :posts, except: [:index]

  root to: "subs#index"
end
