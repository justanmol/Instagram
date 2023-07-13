Rails.application.routes.draw do
  post '/user/login', to: 'user#login'
  post '/user/signup', to: 'user#signup'
  post '/like', to: 'likes#create'

  # resources :user
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :user do
    member do 
      get 'posts'
    end 
  end   
end