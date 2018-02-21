class ListsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_display_user
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user
      @lists = sortable_venues_array(List.where(user_id: @user.id), 'list')
    else
      @lists = sortable_venues_array(List.where(user_id: @user.id).publicLists, 'list')
    end

    respond_with(@lists)
  end

  def show
    if @user != @list.user
      redirect_to user_list_path(@list.user, @list)
    else
      @sorted_list = sortable_venues_array(@list.list_items, 'list_item')
      respond_with(@list.user, @list)
    end
  end

  def new
    @list = List.new
    respond_with(@list.user, @list)
  end

  def edit
    if current_user != @list.user
      redirect_to @list.user
    end
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    @list.save
    respond_with(@user, @list)
  end

  def update
    @list.update(list_params)
    respond_with(@list.user, @list)
  end

  def destroy
    @list.destroy
    respond_with(@list.user, @list)
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:user_id, :private, :showmap, :title, :description)
    end
end
