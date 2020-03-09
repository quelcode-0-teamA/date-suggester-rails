Rails.application.routes.draw do
  root 'v1/top#index'
  namespace :v1, format: 'json' do
    namespace 'temp_user' do
      resources :sign_up, only: %i[create]
    end
    namespace 'formal_user' do
      resources :sign_up, only: %i[create]
    end
    resources :sign_in, only: %i[create]
    resources :users, only: %i[show update destroy] do
    end
    resources :areas, only: %i[index]
    resources :spots, only: %i[show]
    resources :plans, only: %i[show] do
      collection do
        resource :suggest, controller: :plans_suggest, only: %i[show]
      end
    end
    resources :my_plans, only: %i[index create show destroy]
  end
end
