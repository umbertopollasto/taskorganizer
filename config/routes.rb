Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'

  # User route

  get '/add_user', to: 'users#new'
  post '/add_user', to: 'users#create'

  get '/add_project', to: 'projects#new'
  post '/add_project', to: 'projects#create'
end
