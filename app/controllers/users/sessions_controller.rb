# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :authenticate_user! # S'assurer que l'utilisateur est connecté
  
  def show
    @user = current_user
  end

end
