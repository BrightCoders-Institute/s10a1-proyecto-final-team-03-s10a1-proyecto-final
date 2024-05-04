Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  resources :users do
    resources :followers, only: %i[create destroy show]
    member do
      get 'chat'
    end
  end

  resources :streaks, only: %i[show]

  resources :images

  resources :routines do
    resources :series do
      resources :exercises
    end
  end

  resources :search

  resources :chats

  resources :rooms do
    resources :messages
  end

  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy] do
      post 'reply', on: :collection
    end
  end
  
  resources :selector
end

