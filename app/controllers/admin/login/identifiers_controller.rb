class Admin::Login::IdentifiersController < ApplicationController
  layout 'login'

  skip_before_action :require_login

  before_action -> { redirect_to admin_dashboard_path }, if: :logged_in?

  def show
    @user = User.new
  end

  def create
    @user = User.find_by(name: user_params.fetch(:name, nil))

    if @user.present?
      session[:login_user_name] = @user.name
      redirect_to admin_login_password_url
    else
      @user = User.new(user_params).tap(&:valid?)
      @user.errors.add(:name, 'ユーザーが登録されていません')
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
