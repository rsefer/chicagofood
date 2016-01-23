class Api::V1::VenuesController < Api::ApiController
  before_action :set_venue, only: [:show]

  def index
    @venues = Venue.all
    respond_with @venues
  end

  def show
    render json: @venue
  end

  private
    def set_venue
      @venue = Venue.find(params[:id])
    end

end
