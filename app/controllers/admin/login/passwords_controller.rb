class Admin::Login::PasswordsController < ApplicationController
  layout 'login'

  skip_before_action :require_login

  def show
    @user = User.new(name: session.delete(:login_user_name))
  end

  def create
    @user = User.find_by!(name: user_params.fetch(:name, nil))

    if @user.valid_password?(user_params.fetch(:password, nil))
      auto_login(@user)
      redirect_to admin_url
    else
      @user = User.new(user_params)
      @user.errors.add(:password, 'パスワードが正しくありません')
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
