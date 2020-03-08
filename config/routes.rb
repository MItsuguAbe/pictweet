
Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'

  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end

  resources :users, only: :show

  post "likes/:tweet_id/create" => "likes#create"
  post "likes/:tweet_id/destroy" => "likes#destroy"

  get "users/:id/likes" => "users#likes"
end