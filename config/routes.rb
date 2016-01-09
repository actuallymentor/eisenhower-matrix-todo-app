Rails.application.routes.draw do

  # Devise auth config
  devise_for :users, controllers: { sessions: "users/sessions" },  path: "auth", path_names: { 
    sign_in: 'login', 
    sign_out: 'logout', 
    password: 'secret', 
    confirmation: 'verification', 
    unlock: 'unblock', 
    registration: 'register', 
    sign_up: 'signup' 
  }
  devise_scope :user do
    get "/auth/logout", to: "devise/sessions#destroy"
  end
  
  # API mapping
  get '/api/' => 'api#read'
  
  # App mapping
  get '/' => 'pages#index'
  get '/app/' => 'interface#index'
  post '/app/create/' => 'interface#create', as: :tasks
  post '/app/done/' => 'interface#done'
  post '/app/delete/' => 'interface#destroy'

end