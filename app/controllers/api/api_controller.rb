class Api::ApiController < ActionController::Base
  respond_to :json

  private
    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

    def set_display_user
			@user = User.find(params[:user_id])
		end

end
