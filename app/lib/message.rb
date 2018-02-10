# app/lib/Message.rb
class Message
  def self.not_found(record = 'record')
    "#{record} not found."
  end

  def self.invalid_credentials
    "Invalid credentials."
  end

  def self.invalid_token
    "Invalid token."
  end

  def self.missing_token
    "Missing token."
  end

  def self.unauthorized_request
    "Unauthorized request."
  end

  def self.account_created
    "Account created."
  end

  def self.account_not_created
    "Account could not be created."
  end

  def self.account_deleted
    "Account deleted."
  end

  def self.expired_token
    "Expired token. Login to continue."
  end
end
