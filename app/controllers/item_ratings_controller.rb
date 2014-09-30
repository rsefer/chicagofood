class ItemRatingsController < ApplicationController
  before_action :set_item_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_display_user, only: [:index]

  def index
    @item_ratings = ItemRating.all
  end

  def show
  end

  def new
    @item_rating = ItemRating.new
  end

  def edit
  end

  def create
    @item_rating = ItemRating.new(item_rating_params)

    respond_to do |format|
      if @item_rating.save
        format.html { redirect_to :back, notice: 'Item rating was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @item_rating.update_attributes(:liked => params[:liked])
        format.html { redirect_to :back, notice: 'Item rating was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item_rating.destroy
    respond_to do |format|
      format.html { redirect_to item_ratings_url, notice: 'Item rating was successfully destroyed.' }
    end
  end

  private
    def set_item_rating
      @item_rating = ItemRating.find(params[:id])
    end

    def set_display_user
      @user = User.find(params[:user_id])
    end

    def item_rating_params
      params.require(:item_rating).permit(:item_id, :user_id, :liked)
    end
end
