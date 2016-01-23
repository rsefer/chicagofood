class Api::V1::ListsController < Api::ApiController
  before_action :set_list, only: [:show]
  before_action :set_display_user

  def index
    @lists = @user.lists.where(:private => false)
    respond_with @lists
  end

  def show
    if @list.private?
      render json: {
        'error': 'This list is private.'
      }
    else
      render json: {
        list_meta: @list,
        list_items: @list.list_items
      }
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def set_display_user
			@user = User.find(params[:user_id])
		end

end
