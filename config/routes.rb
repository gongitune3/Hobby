Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    regisrrations: 'users/regisrrations'
  }
  
  devise_for :admins, controllers: { 
    sessions: 'admins/sessions',
    regisrrations: 'admins/regisrrations'
  }
  
  root 'users/homes#top'

  # 管理者側
  namespace :admins do
    root 'homes#top'
    resources :contacts,only: [:show,:index,:edit,:update,:destroy]
    resources :users,only: [:show,:index,:edit,:update,:destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
    end
    get 'tags' => 'boards#tag'
    get 'bookmarks' => 'boards#bookmark'
    resources :boards, shallow: true do
      resource :bookmarks, only: [:create,:destroy]
      resources :board_comments, only: [:create,:destroy] do
        resource :favorites, only: [:create,:destroy]
      end
    end
    resource :board_tags, only: [:create,:destroy]
    resources :tags
    get 'search' => 'search#search', as: 'search'
  end

  # ユーザー側
  namespace :users do
    resources :users,only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'bookmarks' => 'boards#bookmark'
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
    end

    get 'tags' => 'boards#tag'
    resources :boards, shallow: true do
      resource :bookmarks, only: [:create,:destroy]
      resources :board_comments, only: [:create,:destroy] do
        resource :favorites, only: [:create,:destroy]
      end
    end

    resource :board_tags, only: [:create,:destroy]
    resources :tags

    get 'search' => 'search#search', as: 'search'
    get 'homes/about'
    get 'contacts/new'
    post 'contacts/create'
  end

end
