class ListsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_display_user
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user
      @lists = List.where(user_id: @user.id)
    else
      @lists = List.where(user_id: @user.id).publicLists
    end

    respond_with(@lists)
  end

  def show
    respond_with(@list.user, @list)
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
    def set_display_user
      @user = User.find(params[:user_id])
    end

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:user_id, :private, :showmap, :title, :description)
    end
end
