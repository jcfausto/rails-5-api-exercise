# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    # call the authentication service
    auth_token = AuthenticateUser.new(
      auth_params[:email],
      auth_params[:password]
    ).call
    # return the json response
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    # will filter params to make user only email and password are allowed
    params.permit(:email, :password)
  end
end
