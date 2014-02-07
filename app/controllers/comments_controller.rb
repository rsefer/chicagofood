class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]
	
	def create
    @venue = Venue.find(params[:venue_id])
    @comment = @venue.comments.create(comment_params)
    @comment.commenterid = current_user.id
    @comment.save
    redirect_to venue_path(@venue)
  end
  
  def destroy
  	@venue = @comment.venue_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to venue_path(@venue) }
    end
  end
  
  private
  	def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:commenterid, :body)
    end
  
end
