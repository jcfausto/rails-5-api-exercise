# spec/requests/todos_spec.rb

require 'rails_helper'

RSpec.describe 'Todo API', type: :request do
  # Initialize test data
  # add todos onwer
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }

  # set Authorization headers
  let(:headers) { valid_headers }

  # GET /todos
  describe 'GET /todos' do
    before { get "/todos", params: {}, headers: headers }

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # POST /todos
  describe 'POST /todos' do
      # Define a valid payload
      let(:valid_attributes) { {title: 'A valid todo title', created_by: user.id}.to_json }
      # Define a invalid payload
      let(:invalid_attributes) { { title: nil }.to_json }

      context 'when the request is valid' do
        before { post "/todos", params: valid_attributes, headers: headers }

        it 'creates a todo' do
          expect(json['title']).to eq('A valid todo title')
        end

        it 'returns a status code 201 (Created)' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post "/todos", params: invalid_attributes, headers: headers }

        it 'returns status code 422 (Unprocessable entity)' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Title can't be blank/)
        end
      end
  end

  # PUT /todos/:id
  describe 'PUT /todos/:id' do
    # Valid payload
    let(:valid_attributes) { { title: 'Walk the dog' }.to_json }

    context 'when the record exist' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204 (No content)' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'returns status code 404 (Not found)' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }

    it 'returns status code 204 (No content)' do
      expect(response).to have_http_status(204)
    end
  end

end
