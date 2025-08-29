Rails.application.routes.draw do
  root "sessions#new"

  resource :session, only: [ :show, :new, :create, :destroy ]
  resources :passwords, param: :token

  resources :articulos do
    collection { post :import }
  end

  resources :personas do
    collection { post :import }
  end

  resources :transferencias do
    collection { post :import }
  end

  get "dashboard", to: "dashboard#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
