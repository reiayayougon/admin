class Development::SessionsController < ApplicationController
  skip_before_action :require_login

  def login_as
    user = User.find(params[:user_id])
    auto_login(user)
    redirect_to admin_url, notice: "Signed in! [#{user.id}]"
  end
end
