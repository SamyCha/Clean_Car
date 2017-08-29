class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # decommenter cette ligne sinon gros trou dans le site ! :O
  # skip_before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.cleaner
      dashboard_path(current_user)
    else
      Car.where(user_id: current_user.id).blank? ? new_car_path(current_user) : new_cleaning_path
    end
  end

  def after_sign_up_path_for(resource)
    if current_user.cleaner
      user_path(current_user)
    else
      Car.where(user_id: current_user.id).blank? ? new_car_path(current_user) : new_cleaning_path
    end
  end

  def configure_permitted_parameters
    # rajouter ici les keys pour les champs à add lors du sign-up
    # https://karr.lewagon.org/lectures/rails/07-authentication#/5/3
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :phonenumber, :address, :cleaner])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
