class TriesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :set_try, only: [:show, :edit, :update, :destroy]
	before_action :set_display_user, only: [:index]

	def index
		@tries = sortable_venues_array(Try.where(user_id: @user.id), 'try')
	end

	def create
    @venue = Venue.find(params[:venue_id])
    @try = @venue.tries.create(try_params)
    @try.user_id = current_user.id
    @try.save
    redirect_to venue_path(@venue)
  end

  def destroy
  	@venue = @try.venue
    @try.destroy

    redirect_to :back
  end

  def show
  end

  private
  	def set_try
      @try = Try.find(params[:id])
    end

		def set_display_user
			@user = User.find(params[:user_id])
		end

    def try_params
      params.require(:try).permit(:user_id, :venue_id)
    end

end
