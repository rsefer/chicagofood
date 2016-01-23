class Api::V1::RatingsController < Api::ApiController
  before_action :set_display_user

  def index
    @ratings = @user.ratings
    respond_with @ratings
  end

  private
    def set_display_user
			@user = User.find(params[:user_id])
		end

end
