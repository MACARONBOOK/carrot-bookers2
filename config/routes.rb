Rails.application.routes.draw do
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   # resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end

  post '/books/:book_id/favorites' => 'favorites#create', as: 'book_favorites'
  delete '/books/:book_id/favorites' => 'favorites#destroy', as: 'destroy_favorites'

  get 'search'=> 'searches#search'

end