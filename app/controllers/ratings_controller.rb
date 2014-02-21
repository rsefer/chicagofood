class RatingsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :set_rating, only: [:show, :edit, :update, :destroy]

	def create
    @venue = Venue.find(params[:venue_id])
    @rating = @venue.ratings.create(rating_params)
    @rating.raterid = current_user.id
    @rating.save
    redirect_to venue_path(@venue)
  end
  
  def update
  	respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to venue_path(@rating.venue_id), notice: 'Rating was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  private
  	def set_rating
      @rating = Rating.find(params[:id])
    end

    def rating_params
      params.require(:rating).permit(:raterid, :rating)
    end
  
end
