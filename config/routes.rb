Rails.application.routes.draw do
  root to: "events#index"

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  resources :events do
    collection do
      get :my_events
      get :pending
    end
    member do
      patch :validate
    end
    resources :event_pictures, only: %i[create]
  end

  resources :attendances, only: %i[create show]

  devise_scope :user do
    get "profil", to: "devise/registrations#show", as: :user_profile
  end

  get "static_pages/secret", to: "static_pages#secret", as: "static_pages_secret"

  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Autres routes
  get "up" => "rails/health#show", as: :rails_health_check
end
