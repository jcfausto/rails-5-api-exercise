# app/lib/api_version.rb
class ApiVersion
  attr_reader :version, :default

  # constructor
  def initialize(version, default = false)
    @version = version
    @default = default
  end

  # Content negotiation
  # Check if the api version is specific or default
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  # Check if Accept was defined in headers and includes the API version
  def check_headers(headers)
    accept = headers[:accept]
    accept && accept.include?("application/vnd.todos.#{version}+json")
  end
end
