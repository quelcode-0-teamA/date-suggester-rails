# == Route Map
#
#                       Prefix Verb   URI Pattern                       Controller#Action
#                         root GET    /                                 v1/top#index
#   v1_temp_user_sign_up_index POST   /v1/temp_user/sign_up(.:format)   v1/temp_user/sign_up#create {:format=>/json/}
# v1_formal_user_sign_up_index POST   /v1/formal_user/sign_up(.:format) v1/formal_user/sign_up#create {:format=>/json/}
#             v1_sign_in_index POST   /v1/sign_in(.:format)             v1/sign_in#create {:format=>/json/}
#                      v1_user GET    /v1/users/:id(.:format)           v1/users#show {:format=>/json/}
#                              PATCH  /v1/users/:id(.:format)           v1/users#update {:format=>/json/}
#                              PUT    /v1/users/:id(.:format)           v1/users#update {:format=>/json/}
#                              DELETE /v1/users/:id(.:format)           v1/users#destroy {:format=>/json/}
#                     v1_areas GET    /v1/areas(.:format)               v1/areas#index {:format=>/json/}
#                      v1_spot GET    /v1/spots/:id(.:format)           v1/spots#show {:format=>/json/}
#                   v1_suggest GET    /v1/plans/suggest(.:format)       v1/plans_suggest#show {:format=>/json/}
#                      v1_plan GET    /v1/plans/:id(.:format)           v1/plans#show {:format=>/json/}
#                  v1_my_plans GET    /v1/my_plans(.:format)            v1/my_plans#index {:format=>/json/}
#                              POST   /v1/my_plans(.:format)            v1/my_plans#create {:format=>/json/}
#                   v1_my_plan GET    /v1/my_plans/:id(.:format)        v1/my_plans#show {:format=>/json/}
#                              DELETE /v1/my_plans/:id(.:format)        v1/my_plans#destroy {:format=>/json/}

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
    resources :users, only: %i[show update destroy]
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
