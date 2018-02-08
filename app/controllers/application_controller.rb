class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # Including the concerns so that they're available to controllers
  include Response
  include ExceptionHandler

  # Authenticate every request before dispatching to the action
  before_action :authorize_request
  # Make current_user available to controllers
  attr_reader :current_user

  private

  def authorize_request
    # call the authorization service to check the token and return the user
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

end
