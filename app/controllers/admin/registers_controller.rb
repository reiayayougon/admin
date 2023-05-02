class Admin::RegistersController < ApplicationController
  layout 'login'

  skip_before_action :require_login

  before_action :set_invitation
  before_action :user_registered?
  before_action :set_user

  def show; end

  def create
    @user.attributes = user_params

    if @user.save
      Invitation.where(name: @user.name).destroy_all

      auto_login(@user)

      redirect_to admin_dashboard_path
    else
      render :show
    end
  end

  private

  def invitation_params
    ActionController::Parameters.new(@invitation.attributes)
  end

  def user_params
    params.require(:user).permit(policy(:user).permitted_attributes)
  end

  def set_invitation
    @invitation = Invitation.validity.find_by!(uuid: params[:invitation_uuid])
  end

  def user_registered?
    raise ActiveRecord::RecordNotFound if User.exists?(name: @invitation.name)
  end

  def set_user
    @user = User.new(invitation_params.permit(:name, :role))
  end
end
