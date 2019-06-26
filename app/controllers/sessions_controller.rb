# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :require_login, only: :create

  api :POST, '/login', <<-DESC
    Log in as user.
    This action also set a cookie with a valid token in the response
    So, you need to send the credentials of the browser
  DESC

  param :email, String, desc: 'user email', required: true
  param :password, String, desc: 'user passwond', required: true

  returns code: :ok, desc: 'Details about logged in user' do
    property :id, Integer, desc: 'Id of the logged in user'
    property :name, String, desc: 'Name of the logged in user'
    property :email, String, desc: 'Email of the logged in user'
  end

  returns code: :bad_request, desc: 'Unauthorized request' do
    property :errors, Hash, desc: 'Incorrect email or password'
  end
  def create
    user = User.valid_login?(params[:email], params[:password])
    if user
      regenerate_and_signed_token(user)
      render json: user
    else
      render json: { errors: 'Incorrect email or password' },
             status: :bad_request
    end
  end

  api :DELETE, '/logout', 'Log out as user'
  returns code: :ok, desc: 'Log out successfully'
  returns code: :unauthorized, desc: 'Required login' do
    property :errors, Hash, desc: 'Access denied'
  end
  def destroy
    current_user.invalidate_token
    head :ok
  end
end
