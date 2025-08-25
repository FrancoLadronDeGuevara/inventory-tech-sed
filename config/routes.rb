Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :articulos do
    resources :transferencias, only: [ :new, :create, :index ]
  end

  resources :personas
  resources :transferencias, only: [ :index, :show ]
end
