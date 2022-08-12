Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'

  # User route

  get '/add_user', to: 'users#new'
  post '/add_user', to: 'users#create'

  # User's profile
  get '/user/:id', to: 'users#show', as: 'profile'

  get '/add_project', to: 'projects#new'
  post '/add_project', to: 'projects#create'

  get '/work_day', to: 'work_days#index'
  post '/work_day', to: 'work_days#create'
end
