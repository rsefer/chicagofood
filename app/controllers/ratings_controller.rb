class RatingsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :set_rating, only: [:show, :edit, :update, :destroy]
	before_action :set_display_user, only: [:index]

	def index
		@ratings = sortable_venues_array(Rating.where(user_id: @user.id), 'rating')
	end

	def create
    @venue = Venue.find(params[:venue_id])
    @rating = @venue.ratings.create(rating_params)
    @rating.user_id = current_user.id
    tryExisting = Try.where('user_id = ? AND venue_id = ?', current_user.id, @venue.id).first
    if tryExisting.present?
    	tryExisting.destroy
    end
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

		def set_display_user
			@user = User.find(params[:user_id])
		end

    def rating_params
      params.require(:rating).permit(:user_id, :rating)
    end

end
