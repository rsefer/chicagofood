class TriesController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :set_try, only: [:show, :edit, :update, :destroy]
	
	def index
		@user = User.find(params[:user_id])
		@tries = Try.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
	end
	
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
    
    redirect_to :back
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