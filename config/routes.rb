Rails.application.routes.draw do
  root :to => 'users#index'
  resources :user_sessions  #, :only => [:new, :create, :destroy]
  resources :users          #, :only => [:index, :new, :create, :show]
   
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout 

  namespace :admin do
    get '/' => 'dashboard#index'
    get '/sign_in' => 'sessions#new'
    post '/sign_in' => 'sessions#create'
    get '/sign_out' => 'sessions#destroy'

  end

end
