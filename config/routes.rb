Rails.application.routes.draw do
  root 'v1/top#index'
  namespace :v1, format: 'json' do
    # Users
    resources :users, only: %i[show update destroy]
    post 'temp_sign_up', to: 'users#create_temp_user'
    post 'formal_sign_up', to: 'users#update_from_temp_to_formal'
    post 'login', to: 'users#login'
    # Plans
    resources :plans, only: %i[show]
    # Spots
    resources :spots, only: %i[show]
    # DateSuggests
    get 'date-suggest', to: 'date_suggests#suggest'
    # MyPlans
    namespace :mypage do
      resources :my_plans, only: %i[index create show destroy]
    end
  end
end
