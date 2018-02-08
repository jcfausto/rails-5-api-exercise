# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # create a user without saving it
  let(:user) { build(:user) }
  # set valid headers
  let(:headers) { valid_headers.except('Authorization') }
  # set valid attributes
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password).to_json
  end

  describe 'POST /signup' do
    before { post '/signup', params: valid_attributes, headers: headers }

    context 'when valid request' do
      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns a success message' do
        expect(json['message']).to match(/Account created/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Password can't be blank/)
      end
    end
  end

end
