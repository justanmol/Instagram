Rails.application.routes.draw do
  post '/user/login', to: 'user#login'
  post '/user/signup', to: 'user#signup'
  post '/like', to: 'likes#create'

  # resources :user
  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy, :index]
  resources :user do
    member do 
      get 'posts'
    end
  end
  # resources :user 
  #   # member do 
  #   #   post '/follow', to: 'users#follow'
  #   #   delete '/unfollow', to: 'users#unfollow'
  #   # end
  post '/follow', to: 'user#follow'
  delete '/unfollow', to: 'user#unfollow'
end