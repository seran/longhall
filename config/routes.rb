Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  devise_for :users
  # devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }, :controllers => {
  #   registrations: 'users/registrations'
  # }

  get '/', to: 'home#index', as: 'home_page'

  get '/projects', to: 'project#index', as: 'projects_list'
  get '/projects/create', to: 'project#new', as: 'new_project'
  post '/projects/create', to: 'project#create', as: 'create_project'
  get '/projects/view/:uuid', to: 'project#view', as: 'view_project'

  get '/scopes', to: 'scope#index', as: 'scopes_list'
  get '/scopes/create/:uuid', to: 'scope#new', as: 'new_scope'
  post '/scopes/create/:uuid', to: 'scope#create', as: 'create_scope'
  get '/scopes/view/:uuid', to: 'scope#view', as: 'view_scope'

  get '/issues', to: 'issue#index', as: 'issues_list'
  get '/issues/create/:uuid', to: 'issue#new', as: 'new_issue'
  post '/issues/create/:uuid', to: 'issue#create', as: 'create_issue'
  get '/issues/view/:uuid', to: 'issue#view', as: 'view_issue'
  
  get '/admin', to: 'admin/general#index', as: 'admin_general_page'
  get '/admin/users', to: 'admin/users#index', as: 'admin_users_page'

  get '/settings', to: 'settings#index', as: 'settings_page'
  get '/help', to: 'help#index', as: 'help_page'

end
