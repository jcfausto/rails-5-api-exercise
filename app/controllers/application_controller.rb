class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Including the concerns so that they're available to controllers
  include Response
  include ExceptionHandler
end
