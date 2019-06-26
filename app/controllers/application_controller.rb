# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :require_login

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def render_unauthorized(message)
    errors = { errors: { message: message } }
    render json: errors, status: :unauthorized
  end

  def authenticate_token
    User.find_by_token(cookies.signed[:auth_token])
  end
end
