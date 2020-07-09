Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #管理者側root
  namespace :admin do
    root 'homes#top'
  end

  #ユーザー側root
  namespace :user do
    resources :users,only: [:show,:index,:edit,:update] do
      root 'home#top'
      resource :favorites, only: [:create,:destroy]
      resources :board_comments, only: [:create,:destroy]
      resources :bookmraks, only: [:create,:destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
    end
  
    resource :board_tags, only: [:create,:destroy]
    resources :boards
    resources :tags
    resources :inquiries, only: [:new,:create]
  end

end
