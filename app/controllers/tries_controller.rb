class TriesController < ApplicationController
	before_action :set_try, only: [:show, :edit, :update, :destroy]
	
	def create
    @venue = Venue.find(params[:venue_id])
    @try = @venue.tries.create(try_params)
    @try.user_id = current_user.id
    @try.save
    redirect_to venue_path(@venue)
  end
  
  def destroy
  	@venue = @try.venue_id
    @try.destroy
    respond_to do |format|
      format.html { redirect_to venue_path(@venue) }
    end
  end
  
  def show
  end
  
  private
  	def set_try
      @try = Try.find(params[:id])
    end

    def try_params
      params.require(:try).permit(:user_id, :venue_id)
    end

end