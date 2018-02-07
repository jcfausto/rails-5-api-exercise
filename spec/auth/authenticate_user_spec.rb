# spec/auth/authenticate_user_spec.rb
require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create a test user
  let(:user) { create(:user) }
  # valid auth object
  let(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid auth object
  let(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  describe '#call' do
    context 'when valid credentials' do
        it 'returns an auth token' do
          token = valid_auth_obj.call
          expect(token).not_to be_nil
        end
    end

    context 'when invalid credentials' do
      it 'returns an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            Message.invalid_credentials
          )
      end
    end
  end
end
