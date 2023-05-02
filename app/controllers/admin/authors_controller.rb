class Admin::AuthorsController < ApplicationController
  layout 'admin'

  before_action :set_authors, only: %i[index]
  before_action :set_author, only: %i[edit update destroy]

  def index
    authorize(Author)

    @author = Author.new
  end

  def create
    authorize(Author)

    @author = Author.new(author_params)

    if @author.save
      redirect_to admin_authors_path
    else
      set_authors
      render :index
    end
  end

  def edit
    authorize(@author)
  end

  def update
    authorize(@author)

    if @author.update(author_params)
      redirect_to admin_authors_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@author)

    @author.destroy

    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :slug, :description, :avatar)
  end

  def set_author
    @author = Author.find(params[:id])
  end

  def set_authors
    @authors = Author.all.order(:slug)
  end
end
