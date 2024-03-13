Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: { registrations: 'users/registrations', sessions: 'users/sessions',
                            omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users
  resources :posts
end
