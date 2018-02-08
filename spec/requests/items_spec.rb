# spec/requests/items_spec.rb

require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  # Initialize test data
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  # GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200 (OK)' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404 (Not found)' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    context 'when the item exists' do
      it 'returns status code 200 (OK)' do
        expect(response).to have_http_status(200)
      end

      it 'returns the todo item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 30 }

      it 'returns status code 404 (Not found)' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # POST /todos/:todo_id/items
  describe 'POST /todos/:todo_id/items' do
    # Valid attributes
    let!(:valid_attributes) { { name: 'Shopping', done: false }.to_json }

    before { post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers }

    context 'when request attributes are valid' do
      it 'returns status code 201 (Created)' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      before { post "/todos/#{todo_id}/items", params: {}, headers: headers }

      it 'returns status code 422 (Unprocessable entity)' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let!(:valid_attributes) { { name: 'Groceries' }.to_json }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers }

    context 'when item exists' do
      it 'returns status code 204 (No content)' do
        expect(response).to have_http_status(204)
      end

      it 'updated the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Groceries/)
      end
    end

    context 'when item does not exist' do
      let(:id) { 100 }

      it 'returns status code 404 (Not found)' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # DELETE /todos/:todo_id/items/:id
  describe 'DELETE /todos/:todo_id/items/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    it 'returns status code 204 (No content)' do
      expect(response).to have_http_status(204)
    end
  end

end
