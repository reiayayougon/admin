class Admin::LogoutsController < ApplicationController
  def destroy
    logout
    redirect_to admin_path
  end
end
