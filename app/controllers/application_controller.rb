class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # Including the concerns so that they're available to controllers
  include Response
  include ExceptionHandler
end
