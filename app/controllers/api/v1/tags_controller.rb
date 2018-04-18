class Api::V1::TagsController < Api::ApiController
  before_action :set_tag, only: [:show]

  def index
    @tags = Tag.all
    respond_with @tags
  end

  def show
    render json: @tag
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

end
