class Admin::CategoriesController < ApplicationController
  layout 'admin'

  before_action :set_categories, only: %i[index]
  before_action :set_category, only: %i[edit update destroy]

  def index
    authorize(Category)

    @category = Category.new
  end

  def create
    authorize(Category)

    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path
    else
      set_categories
      render :index
    end
  end

  def edit
    authorize(@category)
  end

  def update
    authorize(@category)

    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@category)

    @category.destroy

    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all.order(:slug)
  end
end
