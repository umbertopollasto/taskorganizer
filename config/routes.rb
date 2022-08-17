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

  # Linking Users to projects
  get '/project_users', to: 'project_users#new'
  post '/project_users', to: 'project_users#create'

  get '/users_by_project_id/:id', to: 'project_users#users_by_project'
  get '/projects_by_user_id/:id', to: 'project_users#projects_by_user'

  get '/export_all', to: 'work_days#export'

  # exporter
  get '/export', to: 'exporter#new'
  get '/export_csv', to: 'exporter#create'
end
