# app/models/user.rb
class User < ApplicationRecord
  has_many :todos, foreign_key: :created_by

  # Encrypt password
  has_secure_password

  # Validations
  validates_presence_of :name, :email, :password_digest
end
