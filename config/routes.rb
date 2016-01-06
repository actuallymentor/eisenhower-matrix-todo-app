Rails.application.routes.draw do
 
  devise_for :users
  get 'interface/index'

 # Map a front page
  get '/' => 'pages#index'

  # API mapping
  get '/api/' => 'api#read'
  
  # App mapping
  get '/app/' => 'interface#index'
  post '/app/create/' => 'interface#create', as: :tasks
  post '/app/done/' => 'interface#done'
  post '/app/delete/' => 'interface#destroy'

end