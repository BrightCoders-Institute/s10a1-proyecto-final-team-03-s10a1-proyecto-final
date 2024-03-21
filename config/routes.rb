Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  resources :users

  resources :posts do
    resources :likes, only: %i[create destroy]
  end
end
