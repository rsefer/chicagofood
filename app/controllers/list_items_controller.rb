class ListItemsController < ApplicationController
  before_filter :authenticate_user!
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
      params.require(:list_item).permit(:list_id, :venue_id, :date, :notes)
    end

end
