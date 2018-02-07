# app/auth/authenticate_user.rb
class AuthenticateUser
  # constructor
  def initialize(email, password)
    @email = email
    @password = password
  end

  # entry point
  def call
    # return a valid token if the authentication succeeds
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # if was not possible to authenticate, raise an error
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
