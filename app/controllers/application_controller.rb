class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user&.admin?
  end

  private

  def user_not_authorized
    sign_out(User)
    render plain: "Access Not Allowed", status: :forbidden
  end
end
