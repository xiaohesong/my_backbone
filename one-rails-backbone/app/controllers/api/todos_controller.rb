class Api::TodosController < ApplicationController
  respond_to :json

  def index
    @todos = Todo.all
    respond_with @todos, location: nil
  end

  def create
    @todo = Todo.new(params_permit)
    @todo.save!
    respond_with @todos, location: nil
  end

  private
  def params_permit
    params.require(:todo).permit(:content)
  end
end
