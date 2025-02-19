Rails.application.routes.draw do
  root to: "events#index"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :events, only: [:index, :new, :create, :show]

  devise_scope :user do
    get 'profil', to: 'devise/registrations#show', as: :user_profile
  end

  get 'static_pages/secret', to: 'static_pages#secret', as: 'static_pages_secret'

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Autres routes
  get "up" => "rails/health#show", as: :rails_health_check
end
