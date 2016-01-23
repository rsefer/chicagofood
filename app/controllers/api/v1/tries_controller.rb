class Api::V1::TriesController < Api::ApiController
  before_action :set_display_user

  def index
    @tries = @user.tries
    respond_with @tries
  end

  private
    def set_display_user
			@user = User.find(params[:user_id])
		end

end
