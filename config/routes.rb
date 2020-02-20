Rails.application.routes.draw do
  root to: 'v1/users#top', format: 'json'
  namespace :v1, format: 'json' do
    # Users
    resources :users, only: %i[show update destroy]
    post 'sign_up', to: 'users#create'
    post 'login', to: 'users#login'
    # Plans
    resources :plans, only: %i[show]
    # Spots
    resources :spots, only: %i[show]
    # DateSuggests
    get 'date-suggest', to: 'date_suggests#suggest'
    # MyPlans
    namespace :mypage do
      resources :my_plans, only: %i[create show index destroy]
    end
  end
end
