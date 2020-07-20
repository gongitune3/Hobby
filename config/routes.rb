Rails.application.routes.draw do
  namespace :users do
    get 'def/create'
  end
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    regisrrations: 'users/regisrrations'
  }
  
  devise_for :admins
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users/homes#top'

  # 管理者側root
  namespace :admins do
    root 'homes#top'
  end

  # ユーザー側root
  namespace :users do
    root 'home#top'
    resources :users,only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
    end

    resources :boards, shallow: true do
      resource :bookmarks, only: [:create,:destroy]
      resources :board_comments, only: [:create,:destroy] do
        resources :favorites, only: [:create,:destroy]
      end
    end

    resource :board_tags, only: [:create,:destroy]
    resources :tags
    resources :inquiries, only: [:new,:create]

    get 'search' => 'search#search', as: 'search'

  end

end
