Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:create]
  #     post '/login', to: 'sessions#create'
  #     resources :posts, only: [:create] do
  #       post 'like', on: :member
  #       post 'comment', on: :member
  #     end
  #   end
  # end

  resources :user
  post '/user/login', to: 'user#login'
end