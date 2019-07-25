class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :store_user_location!, if: :storable_location?
  before_action :set_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password password_confirmation image])
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || super
  end
end
