Rails.application.routes.draw do
  get "dashboard/index"
  root "sessions#new"

  resource :session, only: [ :show, :new, :create, :destroy ]

  resources :passwords, param: :token
  get "up" => "rails/health#show", as: :rails_health_check

  resources :articulos do
    resources :transferencias, only: [ :new, :create, :index ]
  end

  resources :personas
  resources :transferencias, only: [ :index, :show ]

  get "dashboard", to: "dashboard#index"
end
