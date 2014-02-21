class VenuesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  
  helper_method :sort_column, :sort_direction

  def index
  	@venues = Venue.order(sort_column + " " + sort_direction)
  end

  def show
  end

  def new
    @venue = Venue.new
  end

  def edit
  end

  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url }
    end
  end
  
  def rating_average
  	@venue = Venue.find(params[:venue_id])
  	data = { :rating_average => @venue.ratings.average('rating') }
  	render :json => data, :status => :ok
  end

  private
  	def sort_column
	    Venue.column_names.include?(params[:sort]) ? params[:sort] : "name"
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	  end
	  
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(:name, :url, :typeid, :yelpid, :street, :city, :state, :zipcode, :neighborhoodid, :byob, :craftbeer, :cocktails, :latenight, :price)
    end
end
