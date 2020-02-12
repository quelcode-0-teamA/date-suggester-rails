Rails.application.routes.draw do
  root to: 'v1/users#top'
  namespace :v1, format: 'json' do
    # users
    resources :users, only: %i[show update destroy]
    post '/sign_up', to: 'users#create'
    post '/login', to: 'users#login'

    # date suggests
    get '/date-suggest', to: 'date_suggests#suggest'
  end
end
