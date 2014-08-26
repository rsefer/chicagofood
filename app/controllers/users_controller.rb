class UsersController < ApplicationController

  def index
    @users = User.all.sort{ |a,b| a.firstname <=> b.firstname }

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    @userTries = Try.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userRatings = Rating.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userComments = Comment.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userRecentActivity = @userTries + @userRatings + @userComments
    @userRecentActivity.sort_by(&:updated_at)

    respond_to do |format|
      format.html
    end
  end

  def try
  	@user = User.find(params[:user_id])
  end

end
