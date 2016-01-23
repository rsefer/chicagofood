class Api::V1::UsersController < Api::ApiController
  before_action :set_user, only: [:show]
  before_action :set_user_excludes

  def index
    @users = User.all
    respond_with @users, :except => @user_excludes
  end

  def show
    render :json => @user, :except => @user_excludes
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_user_excludes
      @user_excludes = [:email, :admin, :avatar_file_name, :avatar_updated_at, :city, :state, :street]
    end

end
