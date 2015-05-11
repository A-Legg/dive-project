require 'api_constraints'

DiveApi::Application.routes.draw do
  
  devise_for :users
 
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy] do 
      	resources :dives, :only => [:create, :update, :destroy]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :dives, :only => [:show, :index]
    end
  end
end

  