class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!,except:[:sign_in,:sign_up]
  before_action :configure_permitted_parameters, if: :devise_controller?
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:nickname])
  end
end
