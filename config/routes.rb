Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  resources :users
  resources :posts
end
