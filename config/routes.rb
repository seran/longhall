Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  devise_for :users
  # devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }, :controllers => {
  #   registrations: 'users/registrations'
  # }

  scope ActiveStorage.routes_prefix do
    get "/blobs/redirect/:signed_id/*filename" => "secure_blobs#show"
  end

  get '/', to: 'home#index', as: 'home_page'

  get '/projects', to: 'project#index', as: 'projects_list'
  get '/projects/create', to: 'project#new', as: 'new_project'
  post '/projects/create', to: 'project#create', as: 'create_project'
  get '/projects/view/:uuid', to: 'project#view', as: 'view_project'
  get '/projects/view/:uuid/updates', to: 'project#updates', as: 'view_project_updates'
  get '/projects/edit/:uuid', to: 'project#edit', as: 'edit_project'
  patch '/projects/edit/:uuid', to: 'project#update', as: 'update_project'

  get '/scopes', to: 'scope#index', as: 'scopes_list'
  get '/scopes/create/:uuid', to: 'scope#new', as: 'new_scope'
  post '/scopes/create/:uuid', to: 'scope#create', as: 'create_scope'
  get '/scopes/view/:uuid', to: 'scope#view', as: 'view_scope'
  get '/scopes/view/:uuid/updates', to: 'scope#updates', as: 'view_scope_updates'
  get '/scopes/edit/:uuid', to: 'scope#edit', as: 'edit_scope'
  patch '/scopes/edit/:uuid', to: 'scope#update', as: 'update_scope'

  get '/issues', to: 'issue#index', as: 'issues_list'
  get '/issues/create/(:uuid)', to: 'issue#new', as: 'new_issue'
  post '/issues/create/(:uuid)', to: 'issue#create', as: 'create_issue'
  get '/issues/view/:uuid', to: 'issue#view', as: 'view_issue'
  get '/issues/view/:uuid/updates', to: 'issue#updates', as: 'view_issue_updates'
  get '/issues/edit/:uuid', to: 'issue#edit', as: 'edit_issue'
  patch '/issues/edit/:uuid', to: 'issue#update', as: 'update_issue'
  delete '/issues/a/delete/:uuid/:id', to: 'issue#delete_file', as: 'issue_delete_attachment'

  post '/comments/create/:uuid', to: 'comment#create', as: 'create_comment'
  
  get '/admin', to: 'admin/general#index', as: 'admin_general_page'
  patch '/admin/settings', to: 'admin/general#update', as: 'update_settings'
  get '/admin/users', to: 'admin/users#index', as: 'admin_users_page'
  get '/admin/users/create', to: 'admin/users#new', as: 'new_user'
  post '/admin/users/create', to: 'admin/users#create', as: 'create_user'
  get '/admin/users/edit/:uuid', to: 'admin/users#edit', as: 'edit_user'
  post '/admin/users/edit/:uuid', to: 'admin/users#update', as: 'update_user'

  get '/settings', to: 'settings#index', as: 'settings_page'
  get '/help', to: 'help#index', as: 'help_page'

end
