# app/lib/json_web_token.rb
class JsonWebToken
  # secret to encode and decode the token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp_period = 24.hours.from_now)
    # set the expiration period
    payload[:exp]  = exp_period.to_i
    # encode the token using the secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # extract the payload
    body = JWT.decode(token, HMAC_SECRET)[0] # first item is the payload
    HashWithIndifferentAccess.new body
  # rescue from decoding errors
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
