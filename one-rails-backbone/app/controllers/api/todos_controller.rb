class Api::TodosController < ApplicationController
  # respond_to :json

  def index
    p '='*40
    # respond_with @todo, location: nil
    render json: { xx: 'xx' }
  end
end
