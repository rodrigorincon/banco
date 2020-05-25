class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
 
  protected
 
  def configure_permitted_parameters
  	create_user_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
  	update_user_attrs = [:name, :email]
    devise_parameter_sanitizer.permit :sign_up, keys: create_user_attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_user_attrs
  end
end
