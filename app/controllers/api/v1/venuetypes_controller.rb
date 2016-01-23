class Api::V1::VenuetypesController < Api::ApiController
  before_action :set_venuetype, only: [:show]

  def index
    @venuetypes = Venuetype.all
    respond_with @venuetypes
  end

  def show
    render json: @venuetype
  end

  private
    def set_venuetype
      @venuetype = Venuetype.find(params[:id])
    end

end
