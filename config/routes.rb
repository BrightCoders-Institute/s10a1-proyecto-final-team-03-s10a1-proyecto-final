Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  resources :users do
    resources :followers, only: %i[create destroy show]
  end

  resources :images

  resources :routines do
    resources :series do
      resources :exercises
    end
  end

  resources :search

  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy] do
      post 'reply', on: :collection
    end
  end
end
