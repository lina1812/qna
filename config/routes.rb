require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
    
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  namespace :users do
    resource :get_email, only: %i[show create]
  end
  root to: 'questions#index'

  resources :files, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
    

  resources :questions do
    resources :answers, shallow: true, only: %i[create update destroy] do
      resources :votes, only: %i[create destroy]
      resources :comments, only: :create
      member do
        post :mark_as_best
      end
    end
    resources :votes, only: %i[create destroy]
    resources :comments, only: :create
    member do
      get :subscribe
      get :unsubscribe
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions, only: %i[index show create update destroy] do
        resources :answers, only: %i[index show create update destroy]
      end
    end
  end
end
