Rails.application.routes.draw do
  root to: "events#index"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get 'profil', to: 'devise/registrations#show', as: :user_profile
  end

  get 'static_pages/secret', to: 'static_pages#secret', as: 'static_pages_secret'

  # Autres routes
  get "up" => "rails/health#show", as: :rails_health_check
  resources :events, only: [:index, :new, :create, :show]
end
