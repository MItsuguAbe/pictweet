
Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'

  namespace :tweets do
    resources :searches, only: :index   #resources :tweets doよりも上の行に書くこと。
  end

  resources :tweets do
    resources :comments, only: :create
  end

  resources :users, only: :show

  post "likes/:tweet_id/create" => "likes#create"
  post "likes/:tweet_id/destroy" => "likes#destroy"
end