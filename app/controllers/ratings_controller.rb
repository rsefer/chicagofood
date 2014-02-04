class RatingsController < ApplicationController
	def create
    @venue = Venue.find(params[:venue_id])
    @rating = @venue.ratings.create(params[:rating].permit(:raterid, :rating))
    @rating.raterid = current_user.id
    @rating.save
    redirect_to venue_path(@venue)
  end
end
