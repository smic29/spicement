Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  authenticated :user do
    root "users/dashboard#index", as: :user_root, constraints: lambda { |request| !request.env['warden'].user.admin? unless request.env['warden'].user.nil? }
    root "admin/dashboard#index", as: :admin_root, contraints: lambda { |request| request.env['warden'].user.admin? unless request.env['warden'].user.nil? }
  end
  root "pages#index"

  # authenticated routes
  authenticated :user do
    namespace :admin do
      resources :companies, only: [ :index, :show, :update ]
    end

    namespace :users do
      get "welcome" => "dashboard#show", as: :welcome
    end
  end


  # Pages Routes
  get "login_signup" => "pages#login_signup", as: :auth

  # Company Routes
  resources :companies, only: [ :new, :create ] do
    member do
      get "success", as: :success_new
    end
    collection do
      get "search", as: :search
      post "verify", as: :verify
    end
  end
end
