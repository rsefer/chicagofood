class EatsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_filter :authenticate_user!, except: [:index]
  before_action :set_display_user, only: [:index]

  def index
    @eats = Eat.where(user_id: @user.id)
  end

  def new
  end

  def create
    @eat = current_user.eats.create(eat_params)
    @eat.user_id = current_user.id
    @eat.save

    redirect_to @eat.item.venue
  end

  def destroy
  end

  private
    def eat_params
      params.require(:eat).permit(:item_id, :user_id)
    end

end
