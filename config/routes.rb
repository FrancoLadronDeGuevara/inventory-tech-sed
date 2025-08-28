Rails.application.routes.draw do
  root "sessions#new"

  resource :session, only: [ :show, :new, :create, :destroy ]
  resources :passwords, param: :token

  resources :articulos do
    resources :transferencias, only: [ :new, :create, :index ]
  end

  resources :personas
  resources :transferencias, only: [ :index, :show, :new ]

  get "dashboard", to: "dashboard#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
