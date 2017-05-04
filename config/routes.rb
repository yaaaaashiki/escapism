Rails.application.routes.draw do
  root 'introductions#index'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'thesis/download/:id' => 'theses#download', :as => :download
  get 'search' => 'search#index'
  get 'users/new/:token' => 'users#new'
  get 'visual' => 'visual#index'
  get 'recommendations' => 'recommendations#index'

  namespace :admin do
    get '/' => 'dashboard#index'
    get '/sign_in' => 'sessions#new'
    post '/sign_in' => 'sessions#create'
    get '/sign_out' => 'sessions#destroy'
    resources :users, only: [:index, :new, :create, :edit]
    resources :theses, only: [:index, :edit]
    patch '/users/:id/edit' => 'users#edit' # TODO:必修正updateを使う
    patch '/theses/:id/edit' => 'theses#edit' # TODO:必修正updateを使う
  end

  resources :theses, only: [:show, :index] do
    resources :comments, only: [:create]
  end

  resources :sessions, only: [:create]
  resources :users, only: [:index, :create]
end
