Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    get "search" => "users#search"
  end

  resources :books, only: [:show, :create, :index, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :chats, only: [:show, :create, :destroy]

  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  get "tag_searches/search" => "tag_searches#search"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
