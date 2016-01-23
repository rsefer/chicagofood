class Api::V1::CommentsController < Api::ApiController
  before_action :set_comment, only: [:show]
  before_action :set_display_user

  def index
    @comments = @user.comments.where(:private => false).sort{ |a,b| b.updated_at <=> a.updated_at }
    respond_with @comments
  end

  def show
    if @comment.private?
      render json: {
        'error': 'This comment is private.'
      }
    else
      render json: @comment
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_display_user
			@user = User.find(params[:user_id])
		end

end
