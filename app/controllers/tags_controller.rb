class TagsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.where(parent_tag_id: nil).sort{ |a,b| a.name <=> b.name }
  end

  def show
    paginate_venues(Tag.friendly.find(params[:id]).venues_with_children)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.slug = @tag.name.parameterize

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    if current_user.try(:admin?)
      @tag.destroy
      respond_to do |format|
        format.html { redirect_to tags_url }
      end
    end
  end

  private
    def set_tag
      @tag = Tag.friendly.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name, :slug, :parent_tag_id)
    end
end
