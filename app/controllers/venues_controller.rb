class VenuesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
	after_action :update_geocoder, only: [:create, :update]

  def index
    paginate_venues(Venue.all)
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

	def find_nearby_neighborhoods
    currentStreet = params[:currentStreet]
    currentCity = params[:currentCity]
    currentState = params[:currentState]
    if currentStreet.present? and currentCity.present?
      temp_location = "#{currentStreet}, #{currentCity} #{currentState}"
      s = Geocoder.search(temp_location)
      if !s.empty?
        venue_location = []
        venue_location[0] = s[0].latitude
        venue_location[1] = s[0].longitude
        data = { }
        nearest_venues = Venue.near(venue_location, 0.75, :units => :mi).limit(20)
        neighborhood_list = []
        nearest_venues.each do |venue|
          neighborhood_list.push({ id: venue.neighborhood.id, name: venue.neighborhood.name })
        end
        neighborhood_list  = neighborhood_list.uniq
        data = { :neighborhoods => neighborhood_list }
      	render :json => data, :status => :ok
      end
    end
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
      params.require(:venue).permit(:name, :venuetype_id, :street, :city, :state, :neighborhood_id, :byob, :craftbeer, :cocktails, :latenight, :cashonly, :outdoor, :price)
    end
end
