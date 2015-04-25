Rails.application.routes.draw do
  devise_for :users

  root to: 'articles#index'

  resources :articles, only: %i(show new create edit update destroy) do
    resources :comments, only: :create
  end
end
