class CommentsController < ApplicationController
	def create
    @venue = Venue.find(params[:venue_id])
    @comment = @venue.comments.create(params[:comment].permit(:commenterid, :body))
    @comment.commenterid = current_user.id
    @comment.save
    redirect_to venue_path(@venue)
  end
end
