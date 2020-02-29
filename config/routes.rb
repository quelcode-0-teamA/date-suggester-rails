Rails.application.routes.draw do
  root 'v1/top#index'
  namespace :v1, format: 'json' do
    # Users
    post 'temp_sign_up', to: 'users#create_temp_user'
    post 'formal_sign_up', to: 'users#update_from_temp_to_formal'
    post 'login', to: 'users#login'
    # Areas
    resources :areas, only: %i[index]
    # Plans
    resources :plans, only: %i[show]
    # Spots
    resources :spots, only: %i[show]
    # DateSuggests
    get 'date-suggest', to: 'date_suggests#suggest'
    # MyPlans
    namespace :mypage do
      get :user, to: 'user#show'
      put :user, to: 'user#update'
      delete :user, to: 'user#destroy'
      resources :my_plans, only: %i[index create show destroy]
    end
  end
end
