# app/controllers/concerns/exception_handler.rb

module ExceptionHandler
  # To be able to use the 'included' method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      json_response({ message: exception.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      json_response({ message: exception.message }, :unprocessable_entity)
    end
  end
end
