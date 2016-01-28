class Api::V1::ItemRatingsController < Api::ApiController
  before_action :set_display_user

  def index
    @itemratings = @user.item_ratings
    respond_with @itemratings
  end

end
