class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_admin_user!
    raise Pundit::NotAuthorizedError unless current_user&.admin?
  end

  # def authenticate_admin!
  #   redirect_to new_user_session_path unless current_user&.admin?
  # end

  private

  def user_not_authorized
    sign_out(User)
    render plain: "Access Not Allowed", status: :forbidden
  end
end
