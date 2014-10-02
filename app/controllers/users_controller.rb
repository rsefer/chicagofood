class UsersController < ApplicationController

  def index
    @users = User.all.sort{ |a,b| b.user_score <=> a.user_score }

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    @userTries = Try.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userRatings = Rating.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userComments = Comment.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userItemRatings = ItemRating.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userEats = Eat.where(user_id: @user.id).sort{ |a,b| b.updated_at <=> a.updated_at }
    @userRecentActivity = @userTries + @userRatings + @userComments + @userItemRatings + @userEats
    @userRecentActivity.sort_by(&:updated_at)

    respond_to do |format|
      format.html
    end
  end

  def try
  	@user = User.find(params[:user_id])
  end

end
