Rails.application.routes.draw do
  get "transferencias/index"
  get "transferencias/show"
  get "transferencias/new"
  get "transferencias/create"
  get "personas/index"
  get "personas/show"
  get "personas/new"
  get "personas/create"
  get "personas/edit"
  get "personas/update"
  get "personas/destroy"
  get "articulos/index"
  get "articulos/show"
  get "articulos/new"
  get "articulos/create"
  get "articulos/edit"
  get "articulos/update"
  get "articulos/destroy"
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
