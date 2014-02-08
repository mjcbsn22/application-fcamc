FCAMC::Application.routes.draw do

  get 'login'  => 'sessions#new',     :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  post 'sign_up' => 'welcome#sign_up'

  resources :sessions
  resources :password_resets

  root 'welcome#index'

end
