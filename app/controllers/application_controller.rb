# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include ActionController::Cookies

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
    user = User.find_by_token(cookies.signed[:auth_token])
    regenerate_and_signed_token(user) if user
  end

  def regenerate_and_signed_token(user)
    user.regenerate_token
    cookies.signed[:auth_token] = { value: user.token, httponly: true }
    user
  end
end
