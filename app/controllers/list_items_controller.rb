class ListItemsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :set_list_item, only: [:destroy]
  before_action :set_display_list

  respond_to :html

  def new
    @list_item = ListItem.new
    respond_with(@list.user, @list)
  end

  def create
    @list_item = ListItem.new(list_item_params)
    @list_item.list_id = @list.id
    if params[:manual_entry] == 'true' or params[:manual_entry] == true
      @list_item.manual_entry = true
      @list_item.venue_id = nil
      @list_item.venue_name = params[:venue_name]
      @list_item.neighborhood_id = params[:neighborhood_id]
    end
    @list_item.save
    @list.touch
    respond_with(@list.user, @list)
  end

  def destroy
    @list_item.destroy
    @list.touch
    respond_with(@list.user, @list)
  end

  private
    def set_list_item
      @list_item = ListItem.find(params[:id])
    end

    def list_item_params
      params.require(:list_item).permit(:list_id, :venue_id, :date, :notes, :manual_entry, :venue_name, :neighborhood_id, :tags)
    end

end
