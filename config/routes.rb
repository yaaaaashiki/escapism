Rails.application.routes.draw do
  root 'users#index'
 
  #post 'logout' => 'sessions#destroy', :as => :logout 
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout 

  # postじゃないとダウンロードできない
  get 'search' => 'search#index', :as => :search
  post 'thesis/download/:id' => 'theses#download', :as => :download
  get 'users/new/:token' => 'users#new'
  get 'visual' => 'visual#index'
  get 'introduction' => 'introductions#index'
  
  namespace :admin do
    get '/' => 'dashboard#index'
    get '/users' => 'users#index'
    get '/sign_in' => 'sessions#new'
    post '/sign_in' => 'sessions#create'
    get '/sign_out' => 'sessions#destroy'
    resources :users 
    patch '/users/:id/edit' => 'users#edit'
    get 'thesis' => 'theses#index' 
    patch '/thesis/:id/edit' => 'theses#edit'
    resources :thesis 
  end

  resources :theses, only: [:show, :index] do
    resources :comments
  end

  resources :sessions
  resources :users
end
