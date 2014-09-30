class ItemsController < ApplicationController
  before_action :set_venue
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.venue_id = @venue.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to venue_items_path, notice: 'Item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @venue, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @venuel, notice: 'Item was successfully destroyed.' }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

    def item_params
      params.require(:item).permit(:venue_id, :name)
    end
end
