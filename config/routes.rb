Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true, only: %i[create update destroy] do
      member do
        post :mark_as_best
        get :purge_file
      end
    end
    member do
      get :purge_file
    end
  end
end
