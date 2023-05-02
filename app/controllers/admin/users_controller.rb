class Admin::UsersController < ApplicationController
  layout 'admin'

  before_action :set_user, only: %i[show update destroy]

  def index
    authorize(User)

    @users = User.all.order(:id)
  end

  def show
    authorize(@user)
  end

  def new
    authorize(User)

    @user = User.new
  end

  def create
    authorize(User)

    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def update
    authorize(@user)

    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end

  def destroy
    authorize(@user)

    @user.destroy!

    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(policy(:user).permitted_attributes)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
