Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/create'

  get 'posts/index'

  get 'posts/show'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs

  root to: "subs#index"
end
