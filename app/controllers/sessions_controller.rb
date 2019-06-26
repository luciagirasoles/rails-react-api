# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :require_login, only: :create

  def create
    user = User.valid_login?(params[:email], params[:password])
    if user
      regenerate_and_signed_token(user)
      render json: user
    else
      render_unauthorized('Incorrect email or password')
    end
  end

  def destroy
    current_user.invalidate_token
    head :ok
  end
end
