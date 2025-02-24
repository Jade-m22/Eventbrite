class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permet l'ajout des nouveaux champs dans Devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :description ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :description ])
  end

  def check_if_admin
    redirect_to root_path, alert: "Accès refusé." unless current_user&.is_admin
  end
end
