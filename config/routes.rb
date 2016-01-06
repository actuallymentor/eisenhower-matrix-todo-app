Rails.application.routes.draw do
 
  # Devise auth config
  devise_for :users, controllers: { sessions: "users/sessions" }

  # API mapping
  get '/api/' => 'api#read'
  
  # App mapping
  get '/app/' => 'interface#index'
  post '/app/create/' => 'interface#create', as: :tasks
  post '/app/done/' => 'interface#done'
  post '/app/delete/' => 'interface#destroy'

end