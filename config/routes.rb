Rails.application.routes.draw do
  root 'main#home'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  resources :users
  resources :posts do
    member do
      delete :destroy_image
    end
  end

  get '/posts/:id/destroy_image', to: 'posts#destroy_image'
end
