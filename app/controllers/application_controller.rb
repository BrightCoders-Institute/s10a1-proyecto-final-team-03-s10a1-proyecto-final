# class Aplication Controller
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_streak_if_needed, if: :user_signed_in?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name lastName image_profile])
  end

  def update_streak_if_needed
    current_user.update_streak_if_needed
  end
end
