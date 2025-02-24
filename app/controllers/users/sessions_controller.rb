# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :authenticate_user!
  before_action :check_if_admin, only: %i[index]

  def show
    @user = current_user
  end

  def index
    @users = User.all
  end
  def destroy
    sign_out(current_user)
    redirect_to root_path, notice: "Déconnexion réussie."
  end
end
