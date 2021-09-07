Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :files, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
  resources :votes, only: %i[create destroy]

  resources :questions do
    resources :answers, shallow: true, only: %i[create update destroy] do
      member do
        post :mark_as_best
      end
    end
  end
end
