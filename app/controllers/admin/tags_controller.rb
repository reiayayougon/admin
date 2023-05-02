class Admin::TagsController < ApplicationController
  layout 'admin'

  before_action :set_tags, only: %i[index]
  before_action :set_tag, only: %i[edit update destroy]

  def index
    authorize(Tag)

    @tag = Tag.new
  end

  def create
    authorize(Tag)

    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_path
    else
      set_tags
      render :index
    end
  end

  def edit
    authorize(@tag)
  end

  def update
    authorize(@tag)

    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@tag)

    @tag.destroy

    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :slug)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def set_tags
    @tags = Tag.all.order(:slug)
  end
end
