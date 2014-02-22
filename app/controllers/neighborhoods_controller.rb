class NeighborhoodsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_neighborhood, only: [:show, :edit, :update, :destroy]

  def index
    @neighborhoods = Neighborhood.all.sort{ |a,b| a.name <=> b.name }
  end

  def show
  	@scopeTop = Venue.where(neighborhoodid: @neighborhood.id)
		@scope2nd = Venue.where(neighborhoodid: Neighborhood.where(parentneighborhoodid: @neighborhood.id))
		@scope3rd = Venue.where(neighborhoodid: Neighborhood.where(parentneighborhoodid: Neighborhood.where(parentneighborhoodid: @neighborhood.id)))
		@scope4th = Venue.where(neighborhoodid: Neighborhood.where(parentneighborhoodid: Neighborhood.where(parentneighborhoodid: Neighborhood.where(parentneighborhoodid: @neighborhood.id))))
		
		if (!@scope4th.empty?)
			@scopeTotal = @scopeTop + @scope2nd + @scope3rd + @scope4th
		elsif (!@scope3rd.empty?)
			@scopeTotal = @scopeTop + @scope2nd + @scope3rd
		elsif (!@scope2nd.empty?)
			@scopeTotal = @scopeTop + @scope2nd
		else
			@scopeTotal = @scopeTop
		end
		
		@scopeTotal.sort! { |a, b| a.name <=> b.name }
		@childTypes = Neighborhood.where(parentneighborhoodid: @neighborhood.id).sort! { |a, b| a.name <=> b.name }
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
      params.require(:neighborhood).permit(:name, :parentneighborhoodid)
    end
end
