class Api::V1::UsersController < Api::ApiController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
    respond_with @users
  end

  def show
    render json: @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
