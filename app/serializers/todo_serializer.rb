# app/serializers/todo_serializer.rb
class TodoSerializer < ActiveModel::Serializer
  # Whitelisting the attributes that will be available on the json
  attributes :id, :title, :created_by, :created_at, :updated_at

  # Including the relation
  has_many :items
end
