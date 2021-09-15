Rails.application.routes.draw do
  devise_for :users, controllers: { omiauth_callbacks: 'oauth_callbacks' }
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
  end
end
