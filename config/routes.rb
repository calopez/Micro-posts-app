SampleApp::Application.routes.draw do
  #resources :users
  resources :users do
    # /users/1/following
    # /users/1/followers
    member do
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [ :create, :destroy ]
  resources :relationships, only: [ :create, :destroy ]


  root  'static_pages#home'
  match '/signup',  to: "users#new",            via: :get
  match '/signin',  to: 'sessions#new',         via: :get
  match '/signout', to: 'sessions#destroy',     via: :delete
  match '/help',    to: 'static_pages#help',    via: :get
  match '/about',   to: 'static_pages#about',   via: :get
  match '/contact', to: 'static_pages#contact', via: :get


# This other option 'collections' would response without an
# id like the option 'member'
# 
# /users/tigers/
#
# resources :users do
#   collection do
#     get :tigers
#   end
# end


end
