class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :current_site
  before_action :init_components

  def current_site
    @current_site ||= Site.first
  end
  helper_method :current_site

  def preview!
    @preview = true
  end

  def preview?
    @preview
  end
  helper_method :preview?

  def hide_pagination!
    @components[:pagination] = false
  end

  def pagination?
    @components[:pagination]
  end
  helper_method :pagination?

  def hide_new_arrivals!
    @components[:new_arrivals] = false
  end

  def new_arrivals?
    @components[:new_arrivals]
  end
  helper_method :new_arrivals?

  def categories?
    @components[:categories]
  end
  helper_method :categories?

  private

  def init_components
    @components = {
      pagination: true,
      new_arrivals: true,
      categories: true
    }
  end
end
