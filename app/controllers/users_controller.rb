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

end
