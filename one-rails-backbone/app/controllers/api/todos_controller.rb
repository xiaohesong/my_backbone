class Api::TodosController < ApplicationController
  respond_to :json

  def index
    @todos = Todo.all
    respond_with @todos, location: nil
  end
end
