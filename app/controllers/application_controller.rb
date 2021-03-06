class ApplicationController < ActionController::Base
  include Pundit
  respond_to :html, :json
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  devise_group :any_scope, contains: [:user, :admin]

  rescue_from Pundit::NotAuthorizedError, with: :default_pundit_action

  add_flash_types :success

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name])
  end

  def pundit_user
    current_user || current_admin
  end

  def default_pundit_action
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def render_inactive
    render 'shared/inactive_resource'
  end
end
