class Api::V1::NeighborhoodsController < Api::ApiController
  before_action :set_neighborhood, only: [:show]

  def index
    @neighborhoods = Neighborhood.all
    respond_with @neighborhoods
  end

  def show
    render json: @neighborhood
  end

  private
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end
    
end
