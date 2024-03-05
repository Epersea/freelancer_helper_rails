Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "rate#index"

  get "/rate" => "rate#new"
  post "/rate" => "rate#create"
  get "/rate/:id" => "rate#show", as: :show_rate
  get "/rate/:id/edit" => "rate#edit", as: :edit_rate
  patch "/rate/:id" => "rate#update", as: :update_rate
  delete "/rate/:id" => "rate#destroy", as: :delete_rate

  resources :users, except: :index

  controller :users do
    get 'register' => :new
    post 'register' => :create
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create 
    delete 'logout' => :destroy
  end

  get 'my_summary' => "my_summary#index"

  resources :clients
end
