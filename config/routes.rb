Rails.application.routes.draw do
  devise_for :users
  root 'main#home'

  resources :posts
end
