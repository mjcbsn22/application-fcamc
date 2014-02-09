FCAMC::Application.routes.draw do

  get 'login'  => 'sessions#new',     :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'profile', to: 'profiles#public', as: :public_profile
  resources :profiles,
            path: 'profile',
            param: "username",
            except: [:index]  do
    member do
      patch 'update', to: 'profiles#update_with_ajax', as: :ajax_update
    end
  end

  resources :users, only: [:index] do
    member do
      get 'accept'
      get 'settings', to: 'users#new_account_settings', as: :account_settings
      post 'settings', to: 'users#update_account_settings', as: :update_account_settings
    end
  end

  post 'sign_up' => 'welcome#sign_up'

  resources :sessions
  resources :password_resets

  root 'welcome#index'

end
