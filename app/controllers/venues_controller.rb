class VenuesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
	after_action :update_geocoder, only: [:create, :update]

  def index
    results_per_page = 25
    if params[:page].present?
      @current_page = params[:page].to_i
    else
      @current_page = 1
    end

    @total_pages = (Venue.all.count / results_per_page).ceil
    @venues = sortable_venues_array(Venue.all).drop((@current_page - 1) * results_per_page).take(results_per_page)
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
		@venue.street = @venue.street.titlecase

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
		if @venue.street_changed? or @venue.city_changed? or @venue.state_changed?
			@changed = true
		end

    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
		if current_user.try(:admin?)
			@venue.destroy
			respond_to do |format|
				format.html { redirect_to venues_url }
			end
		end
  end

  def rating_average
  	@venue = Venue.find(params[:venue_id])
  	data = { :rating_average => @venue.ratings.average('rating') }
  	render :json => data, :status => :ok
  end

  def new_venue_search_display
    query = params[:q].downcase
    query.slice! 'the '
    @searchresults = Venue.where("lower(name) LIKE ?", "%#{query}%").first(5)
    respond_to do |format|
      format.js
    end
  end

	def update_item_rating_display
		@item = Item.find(params[:item_id])
    respond_to do |format|
      format.js
    end
  end

  private
    def set_venue
      @venue = Venue.find(params[:id])
    end

		def update_geocoder
			if @venue.street.present? and (@venue.latitude.nil? or @changed)
				new_location = "#{@venue.street} #{@venue.city} #{@venue.state}"
				s = Geocoder.search(new_location)
				@venue.latitude = s[0].latitude
				@venue.longitude = s[0].longitude
				@venue.save
			end
		end

    def venue_params
      params.require(:venue).permit(:name, :venuetype_id, :street, :city, :state, :neighborhood_id, :byob, :craftbeer, :cocktails, :latenight, :cashonly, :price)
    end
end
