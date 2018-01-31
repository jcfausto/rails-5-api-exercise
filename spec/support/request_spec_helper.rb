# spec/support/request_spec_helper
module RequestSpecHelper
  # Parse JSON to a Ruby hash
  def json
    JSON.parse(response.body)
  end
end
