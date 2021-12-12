Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  devise_for :users
  # devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }, :controllers => {
  #   registrations: 'users/registrations'
  # }

  get '/test', to: 'home#index', as: 'home_page'

  get '/projects', to: 'projects#index', as: 'projects_list'
  get '/projects/create', to: 'projects#new', as: 'project_new'
  post '/projects/create', to: 'projects#create', as: 'project_create'

  get '/scopes', to: 'scopes#index', as: 'scopes_list'
  get '/issues', to: 'issues#index', as: 'issues_list'
  
  get '/admin', to: 'admin/general#index', as: 'admin_general_page'
  get '/admin/users', to: 'admin/users#index', as: 'admin_users_page'
  get '/admin/teams', to: 'admin/teams#index', as: 'admin_teams_page'

  get '/settings', to: 'settings#index', as: 'settings_page'
  get '/help', to: 'help#index', as: 'help_page'

end
