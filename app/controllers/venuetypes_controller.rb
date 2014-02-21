class VenuetypesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_venuetype, only: [:show, :edit, :update, :destroy]
  
  helper_method :sort_column, :sort_direction

  def index
    @venuetypes = Venuetype.all.sort{ |a,b| a.name <=> b.name }
  end

  def show
  	@scopeTop = Venue.where(typeid: @venuetype.id)
		@scope2nd = Venue.where(typeid: Venuetype.where(parenttypeid: @venuetype.id))
		@scope3rd = Venue.where(typeid: Venuetype.where(parenttypeid: Venuetype.where(parenttypeid: @venuetype.id)))
		@scope4th = Venue.where(typeid: Venuetype.where(parenttypeid: Venuetype.where(parenttypeid: Venuetype.where(parenttypeid: @venuetype.id))))
		
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
  end

  def new
    @venuetype = Venuetype.new
  end

  def edit
  end

  def create
    @venuetype = Venuetype.new(venuetype_params)

    respond_to do |format|
      if @venuetype.save
        format.html { redirect_to @venuetype, notice: 'Venuetype was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @venuetype.update(venuetype_params)
        format.html { redirect_to @venuetype, notice: 'Venuetype was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @venuetype.destroy
    respond_to do |format|
      format.html { redirect_to venuetypes_url }
    end
  end

  private
  	def sort_column
	    Venue.column_names.include?(params[:sort]) ? params[:sort] : "name"
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	  end
	  
    def set_venuetype
      @venuetype = Venuetype.find(params[:id])
    end

    def venuetype_params
      params.require(:venuetype).permit(:name, :parenttypeid)
    end
end
