class VenuetypesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_venuetype, only: [:show, :edit, :update, :destroy]

  def index
    @venuetypes = Venuetype.where(parent_type_id: nil).sort{ |a,b| a.name <=> b.name }
  end

  def show
    paginate_venues(@venuetype.venues_with_children)
  end

  def new
    @venuetype = Venuetype.new
  end

  def edit
  end

  def create
    @venuetype = Venuetype.new(venuetype_params)

    respond_to do |format|
      if @venuetype.save
        format.html { redirect_to @venuetype, notice: 'Venuetype was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @venuetype.update(venuetype_params)
        format.html { redirect_to @venuetype, notice: 'Venuetype was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    if current_user.try(:admin?)
      @venuetype.destroy
      respond_to do |format|
        format.html { redirect_to venuetypes_url }
      end
    end
  end

  private
    def set_venuetype
      @venuetype = Venuetype.find(params[:id])
    end

    def venuetype_params
      params.require(:venuetype).permit(:name, :parent_type_id)
    end
end
