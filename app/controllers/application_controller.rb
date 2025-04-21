class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name ])
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end

  private

  def set_layout
    if devise_controller?
      "devise"
    elsif admin_namespace?
      "admin"
    elsif user_namespace?
      "user"
    else
      "application"
    end
  end

  def admin_namespace?
    controller_path.start_with?("admin/")
  end

  def user_namespace?
    controller_path.start_with?("user/")
  end
end
