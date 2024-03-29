Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  resources :users
  resources :images
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy] do
      post 'reply', on: :collection
    end
  end
end
