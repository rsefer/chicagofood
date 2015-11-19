class NeighborhoodsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_neighborhood, only: [:show, :edit, :update, :destroy]

  def index
    @neighborhoods = Neighborhood.all
  end

  def show
  	@scopeTop = Venue.where(neighborhood_id: @neighborhood.id)
		@scope2nd = Venue.where(neighborhood_id: Neighborhood.where(parent_neighborhood_id: @neighborhood.id))
		@scope3rd = Venue.where(neighborhood_id: Neighborhood.where(parent_neighborhood_id: Neighborhood.where(parent_neighborhood_id: @neighborhood.id)))
		@scope4th = Venue.where(neighborhood_id: Neighborhood.where(parent_neighborhood_id: Neighborhood.where(parent_neighborhood_id: Neighborhood.where(parent_neighborhood_id: @neighborhood.id))))

		@scopeTotal = @scopeTop + @scope2nd + @scope3rd + @scope4th

    @scopeTotal = sortable_venues_array(@scopeTotal)
		@childTypes = Neighborhood.where(parent_neighborhood_id: @neighborhood.id)
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def edit
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)

    respond_to do |format|
      if @neighborhood.save
        format.html { redirect_to @neighborhood, notice: 'Neighborhood was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @neighborhood.update(neighborhood_params)
        format.html { redirect_to @neighborhood, notice: 'Neighborhood was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @neighborhood.destroy
    respond_to do |format|
      format.html { redirect_to neighborhoods_url }
    end
  end

  private
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end

    def neighborhood_params
      params.require(:neighborhood).permit(:name, :parent_neighborhood_id)
    end
end
