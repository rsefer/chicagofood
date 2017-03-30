class UsersController < ApplicationController
  before_action :set_display_user, only: [:try]

  def index
    @users = User.all.sort{ |a,b| b.user_score <=> a.user_score }
  end

  def show
    @user = User.find(params[:id])
  end

  def try
  end

  def destroy
    if current_user.try(:admin?)
      @user = User.find(params[:id])
      @user.destroy
      if @user.destroy
        redirect_to root_url, notice: "User deleted."
      end
    end
  end

end
