Rails.application.routes.draw do
  root to: 'v1/users#top'
  namespace :v1, format: 'json' do
    # users
    resources :users, only: %i[show update destroy]
    post '/sign_up', to: 'users#create'
    post '/login', to: 'users#login'
    # plans
    resources :plans, only: %i[show]
    # spots
    resources :spots, only: %i[show]
    # date suggests
    get '/date-suggest', to: 'date_suggests#suggest'
    #myPlans
    namespace :mypage do
      resources :plans, only: %i[show index]
      post '/plans/:id', to: 'plans#create'
      put '/plans/:id', to: 'plans#destroy'
    end
  end
end
