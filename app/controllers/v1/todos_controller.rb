# app/controllers/todos_controller.rb
module V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /todos
    def index
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      json_response(@todos)
    end

    # GET /todos/:id
    def show
      json_response(@todo)
    end

    # POST /todos/:id
    def create
      @todo = current_user.todos.create!(todo_params)
      json_response(@todo, :created)
    end

    # PUT /todos/:id
    def update
      @todo.update(todo_params)
      head :no_content
    end

    # DELETE /todos/:id
    def destroy
      @todo.destroy
      head :no_content
    end

    private
      def todo_params
        # Whitelisting allowed params
        params.permit(:title, :created_by)
      end

      def set_todo
        @todo = Todo.find(params[:id])
      end
  end
end
