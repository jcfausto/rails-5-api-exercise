# app/controllers/concerns/exception_handler.rb

module ExceptionHandler
  # To be able to use the 'included' method
  extend ActiveSupport::Concern

  # Defining custom the subclasses
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |exception|
      json_response({ message: exception.message }, :not_found)
    end
  end

  private

  # Status code 422 - unprocessable entity
  def four_twenty_two(exception)
    json_response({ message: exception.message }, :unprocessable_entity)
  end

  # Status code 401 - Unauthorized
  def unauthorized_request(exception)
    json_response({ message: exception.message }, :unauthorized)
  end
end
