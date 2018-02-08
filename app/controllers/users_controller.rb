# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  
  # POST /signup
  # will return an authenticated token upon signup
  def create
    user = User.create!(user_params) # will raise an error if creation fails
    # call the authentication service
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

  private

  def user_params
    # these are the params allowed for creating new users
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
